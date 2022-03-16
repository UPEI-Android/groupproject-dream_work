import type { NextApiRequest, NextApiResponse } from 'next'
import generalHandler from '../../../lib/handler/handler';
import jwt from 'jsonwebtoken'
import { PrismaClient } from '@prisma/client'

interface User {
    username: string,
    email: string,
    password: string,
}

const prisma = new PrismaClient()

export default Object.create(generalHandler)

.post(async (req : NextApiRequest, res : NextApiResponse) => {
    // Authenticate the user
    const { username, email, password } : User = req.body
    if(!((username || email) && password)) return res.status(400).json({ error: 'No username or password provided' })

    let data:any = await prisma.user.findFirst({
        where: {
            OR: [
                {
                    username: username,
                    password: password
                },
                {
                    email: email,
                    password: password
                }
            ],
        },
        select: {
            username: true,
            name: true,
            email: true,
            password: false,
        }
    })

    if(data == null) return res.status(400).json({ error: 'Wrong account information provided'});

    // Create a token
    const accessToken = jwt.sign(data, process.env.ACCESS_TOKEN_SECRET as string)
    // authenticate seccess
    res.status(200).json({ accessToken: accessToken })
})