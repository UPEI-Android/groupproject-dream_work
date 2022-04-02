import type { NextApiResponse, NextApiRequest } from 'next'
import type { todoItem } from '@prisma/client';
import authenticateToken, {ExtendedRequest} from '../../../lib/middleware/authenticateToken';
import DatabaseClient from '../../../lib/dbclient'
import nc from 'next-connect'

const dbclient = DatabaseClient.getInstance().client;

export default nc<NextApiRequest, NextApiResponse>({
    onError(error, req, res) {
        res.status(500).json({ error: `Sorry something Happened! ${error.message}` });
    },
    onNoMatch(req, res) {
        res.status(405).json({ error: `Method '${req.method}' Not Allowed` });
    },
})

.use(authenticateToken)

// query a todo item by its tid(todo item id)
.get(async (req : ExtendedRequest, res: NextApiResponse)=> {
    const { tid } = req.query;

    let data:any = await dbclient.todoItem.findUnique({
        where: {
            tid: tid as string
        }
    })
    if(data.count == 0) return res.status(400).json({ error: 'No todo item found' });
    res.status(200).json(data);
})

// delete a todo item by its tid(todo item id)
.delete(async (req : ExtendedRequest, res: NextApiResponse)=> {
    const { tid } = req.query;
    let data:any = await dbclient.todoItem.deleteMany({
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
.put(async (req : ExtendedRequest, res: NextApiResponse)=> {
    const {tid, section, isDone, create_at, due_at, content} = req.body;
    const uid = req.user.name; // the user name in jwt token

    let data:any = await dbclient.todoItem.updateMany({
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