import generalHandler from '../../lib/handler/handler';
import type { NextApiResponse, NextApiRequest } from 'next'

export default Object.create(generalHandler)

.get((req:NextApiRequest, res:NextApiResponse) => {
    res.status(200).json({
        success: true,
        message: 'message: server is alive'
    })
})
