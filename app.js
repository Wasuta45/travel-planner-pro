const express = require('express');
const session = require('express-session');
const db = require('./db');
const path = require('path'); // เพิ่มตัวจัดการ path
const app = express();

// 1. บอก Express ว่าไฟล์ HTML/CSS/JS อยู่ในโฟลเดอร์ "public"
app.use(express.static(path.join(__dirname, 'public')));

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(session({
    secret: 'secret_key',
    resave: false,
    saveUninitialized: true
}));

// --- API ROUTES (ส่งข้อมูล JSON) ---

// API: สำหรับ Login
app.post('/api/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [users] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
        if (users.length === 0 || users[0].password !== password) {
            return res.status(401).json({ success: false, message: 'รหัสผ่านผิด' });
        }
        // Login ผ่าน
        req.session.userId = users[0].id;
        req.session.username = users[0].username;
        req.session.isLoggedIn = true;
        res.json({ success: true }); // ส่งบอกหน้าบ้านว่า OK
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});

// API: ดึงรายการทริป (Get My Trips)
app.get('/api/my-trips', async (req, res) => {
    if (!req.session.isLoggedIn) {
        return res.status(401).json({ error: 'Not logged in' });
    }
    try {
        const userId = req.session.userId;
        const [trips] = await db.query('SELECT * FROM trips WHERE user_id = ? ORDER BY start_date ASC', [userId]);
        
        // ส่งข้อมูลกลับเป็น JSON (Array ของทริป)
        res.json({ 
            username: req.session.username,
            trips: trips 
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// API: สร้างทริปใหม่
app.post('/api/trips', async (req, res) => {
    if (!req.session.isLoggedIn) return res.status(401).json({ error: 'Not logged in' });
    
    const { name, start_date, end_date, cover_image } = req.body;
    try {
        await db.query(
            'INSERT INTO trips (user_id, name, start_date, end_date, cover_image) VALUES (?, ?, ?, ?, ?)',
            [req.session.userId, name, start_date, end_date, cover_image]
        );
        res.json({ success: true });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// API: Logout
app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/login.html');
});

const PORT = 3000;
// ถ้าคนเข้าหน้าแรก (/) ให้ดีดไปหน้า login.html ทันที
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// --- API: ลบสถานที่ (Delete Place) ---
app.delete('/api/places/:id', async (req, res) => {
    if (!req.session.isLoggedIn) return res.status(401).json({ error: 'Not logged in' });

    const placeId = req.params.id;
    try {
        await db.query('DELETE FROM places WHERE id = ?', [placeId]);
        res.json({ success: true });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});

// --- API: ลบทริป (Delete Trip) ---
app.delete('/api/trips/:id', async (req, res) => {
    if (!req.session.isLoggedIn) return res.status(401).json({ error: 'Not logged in' });

    const tripId = req.params.id;
    try {
        // ลบทริป (สถานที่ข้างในจะหายไปเอง เพราะเราตั้ง cascade ใน Database ไว้แล้ว)
        await db.query('DELETE FROM trips WHERE id = ?', [tripId]);
        res.json({ success: true });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// --- API สำหรับ Places & Map ---

// 1. ดึงข้อมูลทริป + รายการสถานที่ทั้งหมดในทริปนั้น
app.get('/api/trips/:id', async (req, res) => {
    if (!req.session.isLoggedIn) return res.status(401).json({ error: 'Not logged in' });

    const tripId = req.params.id;
    try {
        // ดึงข้อมูลทริป
        const [trip] = await db.query('SELECT * FROM trips WHERE id = ?', [tripId]);
        // ดึงสถานที่ทั้งหมดในทริป
        const [places] = await db.query('SELECT * FROM places WHERE trip_id = ? ORDER BY visit_order ASC', [tripId]);

        if (trip.length === 0) return res.status(404).json({ error: 'Trip not found' });

        res.json({ trip: trip[0], places: places });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// 2. เพิ่มสถานที่ใหม่
app.post('/api/places', async (req, res) => {
    if (!req.session.isLoggedIn) return res.status(401).json({ error: 'Not logged in' });

    // เพิ่ม price รับมาจากหน้าบ้าน
    const { trip_id, name, latitude, longitude, description, price } = req.body; 

    try {
        await db.query(
            // เพิ่ม price ลงใน SQL Insert
            'INSERT INTO places (trip_id, name, latitude, longitude, description, price) VALUES (?, ?, ?, ?, ?, ?)',
            [trip_id, name, latitude, longitude, description, price || 0] // ถ้าไม่กรอกมา ให้เป็น 0
        );
        res.json({ success: true });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// --- API: สมัครสมาชิก (Register) ---
app.post('/api/register', async (req, res) => {
    const { username, password } = req.body;

    try {
        // 1. เช็คก่อนว่า username ซ้ำไหม
        const [existing] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
        if (existing.length > 0) {
            return res.status(400).json({ success: false, message: 'ชื่อผู้ใช้นี้มีคนใช้แล้ว' });
        }

        // 2. ถ้าไม่ซ้ำ ก็สร้าง User ใหม่เลย
        await db.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, password]);
        
        res.json({ success: true });
    } catch (err) {
        res.status(500).json({ success: false, error: err.message });
    }
});