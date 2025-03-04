import admin from 'firebase-admin';
import serviceAccount from './serviceAccountKey.json';

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: '',
});

const authMiddleware = async (req, res, next) => {
    const authHeader = req.headers.authorization;

    if(!authHeader || !authHeader.startsWith('Beared '))
        return res.status(401).send('Unauthorized: Missing Token');

    const token = authHeader.split(' ')[1];

    try{
        //Verify token using firebase auth service
        const decodedToken = await admin.auth().verifyIdToken(token);

        req.user = {
            uid: decodedToken.uid,
            email: decodedToken.email,
        };
        next();

    }catch(err){
        console.error('Token validation failed:', err);
        res.status(401).send('Unauthorizes: Invalid token');
    }
}