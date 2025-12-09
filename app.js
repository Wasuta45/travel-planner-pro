const express = require('express');
const session = require('express-session');
const path = require('path');
const db = require('./db');
const app = express();

// ==========================================
// 1. ตั้งค่าพื้นฐาน (Configuration)
// ==========================================

// ตั้งค่า Static Files และการรับข้อมูล
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// ตั้งค่า Session
app.use(session({
    secret: 'secret_key', 
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 24 * 60 * 60 * 1000 } 
}));

// ==========================================
// 2. Custom Middleware (ฟังก์ชันช่วย)
// ==========================================

// ฟังก์ชันตรวจสอบการล็อกอิน 
const requireAuth = (req, res, next) => {
    if (!req.session.isLoggedIn) {
        return res.status(401).json({ error: 'กรุณาเข้าสู่ระบบก่อนดำเนินการ' });
    }
    next();
};

// ==========================================
// 3. Public Routes (เข้าถึงได้ทุกคน)
// ==========================================

// หน้าแรก (Home Page)
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// API: ดึงข้อมูลหน้า Home (แสดง Stats และ Places ตาม Theme)
app.get('/api/public/home-data', async (req, res) => {
    try {
        const theme = req.query.theme || 'nature';
        //
        const [users] = await db.query('SELECT COUNT(*) as count FROM users');
        const [trips] = await db.query('SELECT COUNT(*) as count FROM trips');
        const [places] = await db.query('SELECT * FROM recommended_places WHERE category = ?', [theme]);

        res.json({
            stats: { users: users[0].count, trips: trips[0].count },
            recommendations: places
        });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// API: ค้นหาสถานที่ (Search)
app.get('/api/search', async (req, res) => {
    const q = req.query.q;
    if (!q) return res.json([]);
    try {
        const [results] = await db.query(
            'SELECT * FROM recommended_places WHERE name LIKE ? OR description LIKE ?', 
            [`%${q}%`, `%${q}%`]
        );
        res.json(results);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// API: ดึงรีวิวของสถานที่ (Public)
app.get('/api/places/:id/reviews', async (req, res) => {
    try {
        const [reviews] = await db.query(`
            SELECT r.*, u.username 
            FROM place_reviews r 
            JOIN users u ON r.user_id = u.id 
            WHERE r.place_id = ? 
            ORDER BY r.created_at DESC`, 
            [req.params.id]
        );
        res.json(reviews);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// API: ดึงรีวิวเว็บไซต์ (Public)
app.get('/api/reviews', async (req, res) => {
    try {
        const [reviews] = await db.query(`
            SELECT r.*, u.username 
            FROM app_reviews r 
            JOIN users u ON r.user_id = u.id 
            ORDER BY r.created_at DESC LIMIT 6
        `);
        res.json(reviews);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// ==========================================
// 4. Auth Routes (สมัคร/เข้าสู่ระบบ)
// ==========================================

// สมัครสมาชิก
app.post('/api/register', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [existing] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
        if (existing.length > 0) return res.status(400).json({ success: false, message: 'ชื่อนี้มีผู้ใช้งานแล้ว' });

        await db.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, password]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ success: false, error: err.message }); }
});

// เข้าสู่ระบบ
app.post('/api/login', async (req, res) => {
    const { username, password } = req.body;
    try {
        const [users] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
        if (users.length === 0 || users[0].password !== password) {
            return res.status(401).json({ success: false, message: 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง' });
        }
        
        // Set Session
        req.session.userId = users[0].id;
        req.session.username = users[0].username;
        req.session.isLoggedIn = true;
        res.json({ success: true });
    } catch (err) { res.status(500).json({ success: false, error: err.message }); }
});

// ออกจากระบบ
app.get('/logout', (req, res) => {
    req.session.destroy();
    res.redirect('/login.html');
});



// --- User Profile ---

// ดึงข้อมูลส่วนตัว
app.get('/api/user/me', requireAuth, async (req, res) => {
    try {
        const [users] = await db.query('SELECT id, username, created_at, bio, avatar_seed FROM users WHERE id = ?', [req.session.userId]);
        if (users.length === 0) return res.status(404).json({ error: 'User not found' });
        res.json(users[0]);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// ดึงสถิติ User
app.get('/api/user/stats', requireAuth, async (req, res) => {
    try {
        const userId = req.session.userId;
        const [tripCount] = await db.query('SELECT COUNT(*) as count FROM trips WHERE user_id = ?', [userId]);
        const [placeCount] = await db.query('SELECT COUNT(*) as count FROM places p JOIN trips t ON p.trip_id = t.id WHERE t.user_id = ?', [userId]);
        const [latestTrip] = await db.query('SELECT * FROM trips WHERE user_id = ? ORDER BY start_date DESC LIMIT 1', [userId]);

        res.json({
            trip_count: tripCount[0].count,
            place_count: placeCount[0].count,
            latest_trip: latestTrip[0] || null
        });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// แก้ไข Bio
app.post('/api/user/edit-profile', requireAuth, async (req, res) => {
    try {
        await db.query('UPDATE users SET bio = ? WHERE id = ?', [req.body.bio, req.session.userId]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// เปลี่ยน Avatar
app.post('/api/user/update-avatar', requireAuth, async (req, res) => {
    try {
        await db.query('UPDATE users SET avatar_seed = ? WHERE id = ?', [req.body.seed, req.session.userId]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// เปลี่ยนรหัสผ่าน
app.post('/api/user/change-password', requireAuth, async (req, res) => {
    const { oldPassword, newPassword } = req.body;
    try {
        const [users] = await db.query('SELECT password FROM users WHERE id = ?', [req.session.userId]);
        if (users[0].password !== oldPassword) return res.json({ success: false, message: 'รหัสผ่านเดิมไม่ถูกต้อง' });
        
        await db.query('UPDATE users SET password = ? WHERE id = ?', [newPassword, req.session.userId]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- Trips Management ---

// ดึงทริปทั้งหมดของผู้ใช้
app.get('/api/my-trips', requireAuth, async (req, res) => {
    try {
        const [trips] = await db.query('SELECT * FROM trips WHERE user_id = ? ORDER BY start_date ASC', [req.session.userId]);
        res.json({ username: req.session.username, trips: trips });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// สร้างทริปใหม่
app.post('/api/trips', requireAuth, async (req, res) => {
    const { name, start_date, end_date, cover_image } = req.body;
    try {
        await db.query(
            'INSERT INTO trips (user_id, name, start_date, end_date, cover_image) VALUES (?, ?, ?, ?, ?)',
            [req.session.userId, name, start_date, end_date, cover_image]
        );
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// ดูรายละเอียดทริป + สถานที่
app.get('/api/trips/:id', requireAuth, async (req, res) => {
    try {
        const [trip] = await db.query('SELECT * FROM trips WHERE id = ?', [req.params.id]);
        if (trip.length === 0) return res.status(404).json({ error: 'Trip not found' });

        const [places] = await db.query('SELECT * FROM places WHERE trip_id = ? ORDER BY visit_order ASC', [req.params.id]);
        res.json({ trip: trip[0], places: places });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// ลบทริป
app.delete('/api/trips/:id', requireAuth, async (req, res) => {
    try {
        // (Optional: ควรเช็คก่อนว่า user เป็นเจ้าของทริปหรือไม่)
        await db.query('DELETE FROM trips WHERE id = ? AND user_id = ?', [req.params.id, req.session.userId]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- Places Management ---

// เพิ่มสถานที่ลงทริป
app.post('/api/places', requireAuth, async (req, res) => {
    const { trip_id, name, latitude, longitude, description, price } = req.body;
    try {
        await db.query(
            'INSERT INTO places (trip_id, name, latitude, longitude, description, price) VALUES (?, ?, ?, ?, ?, ?)',
            [trip_id, name, latitude, longitude, description, price || 0]
        );
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// ลบสถานที่ออกจากทริป
app.delete('/api/places/:id', requireAuth, async (req, res) => {
    try {
        await db.query('DELETE FROM places WHERE id = ?', [req.params.id]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- Reviews (Authenticated) ---

// เขียนรีวิวสถานที่ (Place Review)
app.post('/api/places/:id/reviews', requireAuth, async (req, res) => {
    const { rating, comment } = req.body;
    try {
        await db.query('INSERT INTO place_reviews (place_id, user_id, rating, comment) VALUES (?, ?, ?, ?)', 
            [req.params.id, req.session.userId, rating, comment]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// เขียนรีวิวเว็บ (App Review)
app.post('/api/reviews', requireAuth, async (req, res) => {
    const { rating, comment } = req.body;
    try {
        await db.query('INSERT INTO app_reviews (user_id, rating, comment) VALUES (?, ?, ?)', 
            [req.session.userId, rating, comment]);
        res.json({ success: true });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// ==========================================
// 6. Start Server
// ==========================================
const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});

module.exports = app;