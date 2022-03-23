import type { NextApiRequest, NextApiResponse } from 'next'
import nc from 'next-connect'
import logger from '../../lib/middleware/logger';


export default nc<NextApiRequest, NextApiResponse>({
    onError(error, req, res) {
        res.status(500).json({ error: `Sorry something Happened! ${error.message}` });
    },
    onNoMatch(req, res) {
        res.status(405).json({ error: `Method '${req.method}' Not Allowed` });
    },
})

.use(logger)

