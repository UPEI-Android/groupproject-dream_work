import type { NextApiRequest, NextApiResponse } from 'next'
import type { user } from '@prisma/client'
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
    let { username, email, password } : user = req.body
    if(!(password && (username || email))) return res.status(400).json({ error: 'Incomplete information provided' })
    if(!username) username = email;
    const data = await dbclient.user.create({
        data: {
            username: username,
            password: password,
            name: username,
            email: email,
        }
    })
    res.status(200).json({ success: `User created ${data.email}` })
})