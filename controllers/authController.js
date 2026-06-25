const pool = require('../db');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

exports.registerUser = async (req, res) => {
    const { name, email, password } = req.body;
    try {
        // hash the password before saving
        const hashedPassword = await bcrypt.hash(password, 10);
        //Insert into users table
        await pool.query(
            'INSERT INTO users (name, email, password_hash) VALUES($1, $2, $3)',
            [name, email, hashedPassword]
        );
        res.status(201).json({ message: 'User created successfully' });
    } catch (err) {
        console.error(err);
        res.status(400).json({ error: 'Registration failed' });
    }
};

exports.loginUser = async (req, res) => {
    const { email, password } = req.body;
    try {
        const result = await pool.query(
            'SELECT * FROM users WHERE email = $1',
            [email]
        );

        if (result.rows.length === 0) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        const user = result.rows[0];
        const match = await bcrypt.compare(password, user.password_hash);

        if (!match) {
            return res.status(401).json({ error: 'Invalid credentials' });
        }

        // Generate a JWT token (replace 'secretKey' with a secure secret in env vars)
        const token = jwt.sign({ userId: user.id, email: user.email}, 'secretKey', {
            expiresIn: '1h',
        });


        // TODO: generate JWT or session token here
        res.json({ message: 'Login successful', token });
    } catch (err) {
        console.error('Login error:', err);
        res.status(500).json({ error: 'Server error'});
    }
};