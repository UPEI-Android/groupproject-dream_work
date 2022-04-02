import type { NextApiRequest, NextApiResponse } from 'next'
import type { user } from '@prisma/client'
import jwt from 'jsonwebtoken'
import DatabaseClient from '../../../lib/dbclient';
import nc from 'next-connect'

const dbclient = DatabaseClient.getInstance().client;

// this is api is not protected by jwt token
export default nc<NextApiRequest, NextApiResponse>({
    onError(error, req, res) {
        res.status(500).json({ error: `Sorry something Happened! ${error.message}` });
    },
    onNoMatch(req, res) {
        res.status(405).json({ error: `Method '${req.method}' Not Allowed` });
    },
})

.post(async (req : NextApiRequest, res : NextApiResponse) => {
    // Authenticate the user
    const { username, email, password } : user = req.body
    console.log('login attempt:', username ?? email)
    if(!((username || email) && password)) return res.status(400).json({ error: 'No username or password provided' })
    
    let data = await dbclient.user.findFirst({
        where: {
            OR: [
                {
                    username: username,
                },
                {
                    email: email,
                }
            ],
        },
        select: {
            username: true,
            name: true,
            email: true,
            password: true,
        }
    })

    if(data == null) return res.status(400).json({ error: 'No such user'});

    if(data.password !== password) return res.status(400).json({ error: 'Wrong password'});

    // Create a token
    const accessToken = jwt.sign({name: data.username, email: data.email}, process.env.ACCESS_TOKEN_SECRET as string)
    // authenticate seccess
    res.status(200).json({ accessToken: accessToken })
})