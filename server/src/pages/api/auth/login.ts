import type { NextApiRequest, NextApiResponse } from 'next'
import generalHandler from '../../../lib/handler/handler';
import jwt from 'jsonwebtoken'
import { PrismaClient } from '@prisma/client'

interface User {
    username: string,
    password: string,
}

const prisma = new PrismaClient()

export default Object.create(generalHandler)

.post(async (req : NextApiRequest, res : NextApiResponse) => {
    // Authenticate the user
    const { username, password } : User = req.body
    if(!username || !password) return res.status(400).json({ error: 'No username or password provided' })

    const id = await prisma.user.findUnique({
        where: {
            username: username,
        },
    })

    if(id == null) return res.status(400).json({ error: 'No user found' })
    if(id?.password !== password) return res.status(400).json({ error: 'Wrong username or password' })
    
    // Create a token
    const accessToken = jwt.sign(username, process.env.ACCESS_TOKEN_SECRET as string)
    // authenticate seccess
    res.status(200).json({ accessToken: accessToken })
})