const mysql = require('mysql2/promise');

// ใช้ createPool เพื่อประสิทธิภาพที่ดีกว่า
// โค้ดที่ต้องแก้ไขใน db.js
console.log(process.env.TIDB_HOST)
const connection = mysql.createPool({
  host: process.env.TIDB_HOST,        // 👈 ใช้ TIDB_HOST 
  user: process.env.TIDB_USER,        // 👈 ใช้ TIDB_USER
  password: process.env.TIDB_PASSWORD,  // 👈 ใช้ TIDB_PASSWORD
  database: process.env.TIDB_DATABASE,  // 👈 ใช้ TIDB_DATABASE
  port: process.env.TIDB_PORT || 4000,
  ssl: {
    minVersion: 'TLSv1.2',
    rejectUnauthorized: true
  }
});

module.exports = connection;