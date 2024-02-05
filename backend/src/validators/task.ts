import {body} from 'express-validator'

export const taskCreationValidator = [
    body('title', 'character limit 30').isLength({min: 1, max: 30}).isString(),
    body('tag',  'character limit 15').optional().isLength({min: 1, max: 15}).isString(),
]