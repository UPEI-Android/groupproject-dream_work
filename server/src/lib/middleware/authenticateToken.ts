import type { NextApiRequest, NextApiResponse } from 'next'
import jwt from 'jsonwebtoken'

export interface ExtendedRequest extends NextApiRequest {
    user: {
        name: string;
    }
}

// a JWT authenticate middleware to verify the user
export default (req : ExtendedRequest, res : NextApiResponse, next : Function)=> {
    const authHeader = req.headers.authorization;
    if(!authHeader) return res.status(401).json({ error: 'No token provided' });
    jwt.verify(authHeader, process.env.ACCESS_TOKEN_SECRET as string, (err:any, user:any) => {
        if(err) {
            console.log('auth failed');
            return res.status(403).json({ error: 'Invalid token' })
        }
        req.user = user;
        next();
    })
}