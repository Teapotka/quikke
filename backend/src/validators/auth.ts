import {body} from 'express-validator'

export const registerValidator = [
    body('name', 'minimum 5 characters').isLength({min: 5}),
    body('password', 'minimum 5 characters').isLength({min: 5}),
]
export const loginValidator = [
    body('name', 'minimum 5 characters').isLength({min: 5}),
    body('password', 'minimum 5 characters').isLength({min: 5}),
]