import express from 'express';
import authMiddleware from './middleware/authMiddleware';

const router = express.Router();


router.post('/', authMiddleware, async (req, res) => {
    const message = `User authenticated\n\nuid:${req.user.uid}\nemai:${req.user.emal}`;

    res.status(200).send(message);
});