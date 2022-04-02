import type { NextApiRequest, NextApiResponse } from 'next'

export default (req: NextApiRequest, res: NextApiResponse, next: Function) => {
    
    console.log('req: ' + req.method, req.url, req.headers['x-forwarded-for'] || req.socket.remoteAddress )
    next()
}