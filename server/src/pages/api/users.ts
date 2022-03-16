import jwt from 'jsonwebtoken'
import type { NextApiRequest, NextApiResponse } from 'next'
import nc from 'next-connect'

const handler = nc<NextApiRequest, NextApiResponse>({
    onError(error, req, res) {
        res.status(501).json({ error: `Sorry something Happened! ${error.message}` });
    },
    onNoMatch(req, res) {
        res.status(405).json({ error: `Method '${req.method}' Not Allowed` });
    },
})

.post((req, res) => {
    // Authenticate the user
    const username = req.body.username;
    const password = req.body.password;
    if(!username || !password) {
        res.status(400).json({ error: 'No username or password provided' });
        return;
    }

    const user = { name: username };

    // Create a token
    const accessToken = jwt.sign(user, process.env.ACCESS_TOKEN_SECRET as string)
    
    res.status(200).json({ accessToken: accessToken });
})


export default handler