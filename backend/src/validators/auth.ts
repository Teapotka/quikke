import {body} from 'express-validator'

export const registerValidator = [
    body('login', 'login should be from 5 to 25 characters long').isLength({min: 5, max: 25}),
    body('password', 'password should be from 5 to 25 characters long').isLength({min: 5, max: 25}),
]
export const loginValidator = [
    body('login', 'login should be from 5 to 25 characters long').isLength({min: 5, max: 25}),
    body('password', 'password should be from 5 to 25 characters long').isLength({min: 5, max: 25}),
]