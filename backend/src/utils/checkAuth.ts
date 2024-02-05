import { NextFunction, Request, Response } from 'express'
import jwt from 'jsonwebtoken'

export interface AuthenticatedRequest extends Request {
    userId?: string;
}

export default (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    const token = (req.headers.authorization || '').replace(/Bearer\s?/, '')

    if (token) {
        try {
            const decoded = jwt.verify(token, 'quikke') as jwt.JwtPayload
            req.userId = decoded._id
            next()
        } catch (err) {
            return res.status(403).json({message: 'token denied'})
        }
    } else {
        return res.status(403).json({message: 'access denied'})
    }
}