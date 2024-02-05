"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.taskCreationValidator = void 0;
const express_validator_1 = require("express-validator");
exports.taskCreationValidator = [
    (0, express_validator_1.body)('title', 'character limit 30').isLength({ min: 1, max: 30 }).isString(),
    (0, express_validator_1.body)('tag', 'character limit 15').optional().isLength({ min: 1, max: 15 }).isString(),
];
