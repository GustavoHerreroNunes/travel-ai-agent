import express from 'express';
import cors from 'cors';
import authMiddleware from './authMiddleware.js';

const app = express();
const PORT = 3000;
const router = express.Router();

app.use(cors({
    origin: 'http://localhost:8000',
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization']
}));

app.use(express.json());

router.post('/', authMiddleware, async (req, res) => {
    const message = `User authenticated\n\nuid:${req.user.uid}\nemai:${req.user.email}`;
    console.log(message);

    res.status(200).json({ email: req.user.email });
});

app.use('/', router);

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
})
