import type { NextApiRequest, NextApiResponse } from 'next'
import generalHandler from '../../../lib/handler/handler';
import { PrismaClient } from '@prisma/client'

interface User {
    username: string,
    password: string,
    name: string,
    email: string,
}

const prisma = new PrismaClient()

export default Object.create(generalHandler)

.post((req : NextApiRequest, res : NextApiResponse) => {
    const { username, password, name, email}:User = req.body;
    if(!(username || password || name || email)) return res.status(400).json({ error: 'Incomplete information provided' })
    prisma.user.create({
        data: {
            username: username,
            password: password,
            name: name,
            email: email,
        }
    })

    res.status(200).json({ success: 'User created' })
})