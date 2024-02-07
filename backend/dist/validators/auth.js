"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.loginValidator = exports.registerValidator = void 0;
const express_validator_1 = require("express-validator");
exports.registerValidator = [
    (0, express_validator_1.body)('name', 'name should be from 5 to 25 characters long').isLength({ min: 5, max: 25 }),
    (0, express_validator_1.body)('password', 'password should be from 5 to 25 characters long').isLength({ min: 5, max: 25 }),
];
exports.loginValidator = [
    (0, express_validator_1.body)('name', 'name should be from 5 to 25 characters long').isLength({ min: 5, max: 25 }),
    (0, express_validator_1.body)('password', 'password should be from 5 to 25 characters long').isLength({ min: 5, max: 25 }),
];
