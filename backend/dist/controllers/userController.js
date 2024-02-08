"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.authMe = exports.login = exports.register = void 0;
const user_1 = __importDefault(require("../models/user"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const bcrypt_1 = __importDefault(require("bcrypt"));
const sign = (user) => {
    return jsonwebtoken_1.default.sign({
        _id: user._id,
    }, "quikke", {
        expiresIn: "30d",
    });
};
const register = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { login, password } = req.body;
        const salt = yield bcrypt_1.default.genSalt(10);
        const passwordHash = yield bcrypt_1.default.hash(password, salt);
        const doc = new user_1.default({
            login: login,
            passwordHash: passwordHash,
        });
        const user = yield doc.save();
        const token = sign(user);
        const userInfo = user._doc;
        res.status(200).json({ userInfo, token });
    }
    catch (error) {
        if (error instanceof Error) {
            res.status(500).json({ success: false, error: error.message });
        }
    }
});
exports.register = register;
const login = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { login, password } = req.body;
        const user = yield user_1.default.findOne({ login });
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        const isValid = yield bcrypt_1.default.compare(password, user._doc.passwordHash);
        if (!isValid) {
            return res.status(400).json({ message: "Wrong data" });
        }
        const token = sign(user);
        const userInfo = user._doc;
        res.status(200).json({ userInfo, token });
    }
    catch (err) {
        if (err instanceof Error) {
            console.log(err.message);
            res.status(500).json({ message: err.message });
        }
    }
});
exports.login = login;
const authMe = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const user = yield user_1.default.findById(req.userId);
        if (!user) {
            return res.status(404).json({ message: 'User is not found' });
        }
        const userInfo = user._doc;
        res.status(200).json({ userInfo, token: req.userId });
    }
    catch (err) {
        res.status(500).json({ message: 'Auth processing error' });
    }
});
exports.authMe = authMe;
