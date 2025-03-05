import { initializeApp } from 'firebase-admin/app';
import admin from 'firebase-admin';
import { getAuth } from 'firebase-admin/auth';
import serviceAccount from './serviceAccountKey.json' with { type: 'json' };

initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: '',
});

const authMiddleware = async (req, res, next) => {
    const authHeader = req.headers.authorization;

    if(!authHeader || !authHeader.startsWith('Bearer '))
        return res.status(401).json({ error: 'Unauthorized: Missing Token' });

    const token = authHeader.split(' ')[1];
    console.log(token);

    getAuth()
    .verifyIdToken(token)
    .then((decodedToken) => {
        req.user = {
            uid: decodedToken.uid,
            email: decodedToken.email,
        };
        next();
    })
    .catch((err) => {
        console.error('Token validation failed:', err);
        res.status(401).json({ error: 'Unauthorized: Invalid token' });
    });

    // try{
    //     //Verify token using firebase auth service
    //     const decodedToken = await admin.auth().verifyIdToken(token);

    //     req.user = {
    //         uid: decodedToken.uid,
    //         email: decodedToken.email,
    //     };
    //     next();

    // }catch(err){
    //     console.error('Token validation failed:', err);
    //     res.status(401).json({ error: 'Unauthorized: Invalid token' });
    // }
}

export default authMiddleware;