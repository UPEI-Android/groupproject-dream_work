import type { NextApiRequest, NextApiResponse } from 'next'
import type { user } from '@prisma/client'
import jwt from 'jsonwebtoken'
import generalHandler from '../../../lib/handler/handler';
import DatabaseClient from '../../../lib/dbclient';

const dbclient = DatabaseClient.getInstance().client;

// this is api is not protected by jwt token
export default Object.create(generalHandler)

.post(async (req : NextApiRequest, res : NextApiResponse) => {
    // Authenticate the user
    const { username, email, password } : user = req.body
    if(!((username || email) && password)) return res.status(400).json({ error: 'No username or password provided' })
    
    let data:any = await dbclient.user.findFirst({
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