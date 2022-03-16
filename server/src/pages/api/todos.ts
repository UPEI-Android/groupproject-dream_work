
import type { NextApiRequest, NextApiResponse } from 'next'
import multer from 'multer';
import nc from 'next-connect'
import { v4 as uuidv4 } from 'uuid';
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

const form = multer()

const handler = nc<NextApiRequest, NextApiResponse>({
    onError(error, req, res) {
        res.status(501).json({ error: `Sorry something Happened! ${error.message}` });
    },
    onNoMatch(req, res) {
        res.status(405).json({ error: `Method '${req.method}' Not Allowed` });
    },
})  

// Get a todo items by id
.get(async (req, res)=> {
    const { tid } = req.query;
    let data = await prisma.todoItem.findUnique({
        where: {
            tid: tid as string
        }
    })
    data === null && res.status(400).json({ error: 'No todo item found' });
    res.json(data);
})

// Create a todo item
.post(async (req, res)=> {
    //req.body.tid
    const { gid, members, section, isDone, updated_at, create_at, due_at, content} = req.body;
    const tid = uuidv4();
    await prisma.todoItem.create({
        data: {
            tid: tid,
            gid: gid ? gid : '',
            members: 'test1, test2',
            section: section ? section : undefined,
            isDone: isDone ? true : false,
            updated_at: undefined, //defaut
            created_at: undefined, //defaut
            due_at: due_at ? due_at : '',
            content: content? content : '',
        }
    })
    let data = await prisma.todoItem.findUnique({
        where: {
            tid: tid
        }
    })
    res.status(201).json({data});
})

// Update a todo item
.put((req, res)=> {
    res.json({updated_item: 'req.file'});
})

// Delete a todo item
.delete((req, res)=> {
    res.json({deleted_item: 'test'});
})

// TODO: a JWT middleware to verify the user

export default handler;