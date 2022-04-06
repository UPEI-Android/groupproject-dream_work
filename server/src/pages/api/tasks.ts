import type { NextApiResponse, NextApiRequest } from 'next'
import type { todoItem } from '@prisma/client';
import DatabaseClient from '../../lib/dbclient'
import authenticateToken, {ExtendedRequest} from '../../lib/middleware/authenticateToken';
import nc from 'next-connect'
import logger from '../../lib/middleware/logger';

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
.use(logger)

// query all items by uid (user id)
.get(async (req : ExtendedRequest, res: NextApiResponse)=> {
    const uid = req.user.name; // the user name in jwt token
    const data = await dbclient.todoItem.findMany({
        where: {
            members: {
                contains: uid
            }
        }
    })
    if(data === null) return res.status(400).json({ error: 'No todo item found' });
    res.status(200).json(data);
})

// create a todo item
.post(async (req : ExtendedRequest, res: NextApiResponse)=> {
    const jsonData:Array<todoItem> = req.body
    const user:string = req.user.name // the user name in jwt token

    let data:Array<todoItem> = [] // the user name in jwt token
    for(let item of jsonData) {
        try{
            item.updated_at = new Date() //defaut
            item.created_at = new Date()
            data.push(await dbclient.todoItem.create({
                data: item
            }))
        } catch(e:any){
            console.error(`create item failed, user: ${user} tid: ${item.tid} ${e}` )
        }
    }
    if(data.length == 0) return res.status(400).json({ error: 'No items been create'})
    res.status(200).json({success: data})
})

// delete all todo items by uid (user id) and section
// cation!!
.delete(async (req : ExtendedRequest, res: NextApiResponse)=> {
    const uid = req.user.name; // the user name in jwt token
    const data = await dbclient.todoItem.deleteMany({ 
        where: { 
            members: {
                contains: uid
            }
        }
    })
    if(data.count == 0) return res.status(400).json({ error: 'No items been delete' })
    res.status(200).json({deleted_item: data});
})

// update all todo items by uid (user id) and section (this used for add memeber to a todo item)
.put(async (req : any, res: NextApiResponse)=> {
    const uid = req.user.name; // the user name in jwt token
    const { member, section } = req.body; // new member
    let data = await dbclient.todoItem.updateMany({
        data:{
            members: member
        },
        where:{
            members: {
                contains: uid
            },
            section: section
        }
    })
    if(data.count == 0) res.status(400).json({ error: 'No todo item been update' })
    res.json({updated_item: data})
})
