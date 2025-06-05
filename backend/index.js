const express = require('express');
const pool = require('./src/mysql');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from Express!');
});

app.get('/users', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM users');
    res.json(rows);
  } catch (err) {
    console.error('DB接続が失敗しました:', err);
    res.status(500).json({ message: 'Internal server error' });
  }
});

app.listen(8080, () => {
  console.log('Server is running on port 8080');
});