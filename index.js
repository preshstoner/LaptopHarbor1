const express = require('express');
require('dotenv').config();


const pool = require('./db');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.json());

// Import and use auth routes
const authRoutes = require('./routes/auth');
app.use('/auth', authRoutes);

app.get('/', async (req, res) => {
    const result = await pool.query('SELECT NOW()');
    res.send(`Postgres is alive! Time: ${result.rows[0].now}`);
});

app.listen(port, '0.0.0.0',() => {
    console.log(`Server running on http://0.0.0.0:${port}`);
});