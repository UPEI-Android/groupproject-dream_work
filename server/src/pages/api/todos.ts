
import type { NextApiRequest, NextApiResponse } from 'next'
import nc from 'next-connect'
import jwt from 'jsonwebtoken'
import { v4 as uuidv4 } from 'uuid';
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()


const handler = nc<NextApiRequest, NextApiResponse>({
    onError(error, req, res) {
        res.status(501).json({ error: `Sorry something Happened! ${error.message}` });
    },
    onNoMatch(req, res) {
        res.status(405).json({ error: `Method '${req.method}' Not Allowed` });
    },
})  

// a JWT authenticate middleware to verify the user
const authenticateToken = (req : any, res : NextApiResponse, next : Function)=> {
    const authHeader = req.headers.authorization;
    if(!authHeader) return res.status(401).json({ error: 'No token provided' });
    jwt.verify(authHeader, process.env.ACCESS_TOKEN_SECRET as string, (err:any, user:any) => {
        if(err) return res.status(403).json({ error: 'Invalid token' });
        req.user = user;
        next();
    })
}

handler.use(authenticateToken)

// query a todo items by tid or gid
.get(async (req, res)=> {
    const { tid, gid, members } = req.query; 
    let data;

    data =
    tid ? await prisma.todoItem.findUnique({
        where: {
            tid: tid as string
        }
    })
    : gid ? await prisma.todoItem.findMany({
        where: {
            gid: gid as string
        }
    })
    : members ? await prisma.todoItem.findMany({
        where: {
            members: {
                contains: members as string
            }
        }
    }) 
    : null;

    data === null && res.status(400).json({ error: 'No todo item found' });
    res.status(200).json(data);
})

// Create a todo item
.post(async (req, res)=> {
    const { gid, members, section, isDone, updated_at, create_at, due_at, content} = req.body;

    const tid = uuidv4(); // generate a unique id for the todo item

    // create a todo item
    await prisma.todoItem.create({
        data: {
            tid: tid,
            gid: gid ? gid : 'none',
            members: 'test1, test2',
            section: section ? section : undefined,
            isDone: isDone ? true : false,
            updated_at: undefined, //defaut
            created_at: undefined, //defaut
            due_at: due_at ? due_at : '',
            content: content? content : '',
        }
    })

    // query the todo item
    let data = await prisma.todoItem.findUnique({
        where: {
            tid: tid
        }
    })

    // return the todo item
    res.status(200).json({data});
})

// Update a todo item
.put((req, res)=> {
    res.json({updated_item: 'req.file'});
})

// Delete a todo item by tid or section
.delete(async (req, res)=> {
    const { tid, section } = req.body
    let data:any

    data = tid ? await prisma.todoItem.delete({
        where: {
            tid: tid as string
        }
    })
    : section ? await prisma.todoItem.deleteMany({
        where: {
            section: section
        }
    })
    : null;

    data.count == 0 && res.status(400).json({ error: 'No todo item been delete' })
    res.status(200).json({deleted_item: data});
})


export default handler;