import type { NextApiRequest, NextApiResponse } from 'next'
import handler from '../../../lib/handler/handler';
import { v4 as uuidv4 } from 'uuid';
import { PrismaClient } from '@prisma/client'
import authenticateToken from '../../../lib/middleware/authenticateToken';

const prisma = new PrismaClient()

export default Object.create(handler)

.use(authenticateToken)

// query a todo item by its tid(todo item id)
.get(async (req : NextApiRequest, res: NextApiResponse)=> {
    const { tid } = req.query;

    let data:any = await prisma.todoItem.findUnique({
        where: {
            tid: tid as string
        }
    })

    if(data.count == 0) return res.status(400).json({ error: 'No todo item found' });
    res.status(200).json(data);
})

// create a todo item
.post(async (req : any, res: NextApiResponse)=> {
    const { tid, section, isDone, due_at, content} = req.body;
    const uid = req.user.name; // the user name in jwt token

    let data = await prisma.todoItem.create({
        data: {
            tid: tid,
            members: uid,
            section: section ? section : undefined,
            isDone: isDone ? true : false,
            updated_by: uid,
            updated_at: undefined,
            created_at: undefined, //defaut
            due_at: due_at ? due_at : '',
            content: content? content : '',
        }
    })
    res.status(200).json({data});
})

// delete a todo item by its tid(todo item id)
.delete(async (req : any, res: NextApiResponse)=> {
    const { tid } = req.query;
    let data:any = await prisma.todoItem.deleteMany({
        where: {
            tid: tid as string,
            members: {
                contains: req.user.name
            }
        }
    })
    if(data.count == 0) res.status(400).json({ error: 'No todo item been delete' })
    res.status(200).json({deleted_item: data});
})

// update a todo item by its tid(todo item id)
.put(async (req : any, res: NextApiResponse)=> {
    const {tid, section, isDone, create_at, due_at, content} = req.body;
    const uid = req.user.name; // the user name in jwt token

    let data:any = await prisma.todoItem.updateMany({
        data:{
            updated_by : uid,
            updated_at : undefined, //defaut
            section: section,
            isDone: isDone ? true : false,
            created_at: create_at,
            due_at: due_at,
            content: content
        },
        where:{
            tid: {
                equals: tid as string
            },
            members: {
                contains: uid
            }
        }
    })
    if(data.count == 0) res.status(400).json({ error: 'No todo item been update' })
    res.json({updated_item: data})
})