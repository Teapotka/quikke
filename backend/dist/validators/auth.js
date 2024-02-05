"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.loginValidator = exports.registerValidator = void 0;
const express_validator_1 = require("express-validator");
exports.registerValidator = [
    (0, express_validator_1.body)('name', 'minimum 5 characters').isLength({ min: 5 }),
    (0, express_validator_1.body)('password', 'minimum 5 characters').isLength({ min: 5 }),
];
exports.loginValidator = [
    (0, express_validator_1.body)('name', 'minimum 5 characters').isLength({ min: 5 }),
    (0, express_validator_1.body)('password', 'minimum 5 characters').isLength({ min: 5 }),
];
