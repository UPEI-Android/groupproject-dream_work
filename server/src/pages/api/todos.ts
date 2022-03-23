import type { NextApiRequest, NextApiResponse } from 'next'
import { DatabaseClient, item } from '../../lib/dbclient'
import authenticateToken from '../../lib/middleware/authenticateToken';
import generalHandler from '../../lib/handler/handler';
import logger from '../../lib/middleware/logger';

const dbclient = DatabaseClient.getInstance().client;
interface ExtendedRequest {
    user: {
        name: string;
    }
}
            
export default Object.create(generalHandler)

.use(logger)
.use(authenticateToken)

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
    if(data.count == 0) return res.status(400).json({ error: 'No todo item been delete' })
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
