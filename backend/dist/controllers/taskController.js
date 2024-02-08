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
exports.remove = exports.create = exports.getAllUniqueTags = exports.getFilteredUserTasks = exports.getAllUsersTasks = exports.getAll = void 0;
const task_1 = __importDefault(require("../models/task"));
const getAll = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const tasks = yield task_1.default.find();
        res.json(tasks);
    }
    catch (error) {
        if (error instanceof Error) {
            console.log(error.message);
            res.status(500).json({ message: "Cant get all tasks" });
        }
    }
});
exports.getAll = getAll;
const getAllUsersTasks = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const tasks = yield task_1.default.find({ user: req.userId });
        res.json(tasks);
    }
    catch (error) {
        if (error instanceof Error) {
            console.log(error.message);
            res.status(500).json({ message: "Cant get all tasks" });
        }
    }
});
exports.getAllUsersTasks = getAllUsersTasks;
const getFilteredUserTasks = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const search = req.query.search;
        let tasks;
        if (search.startsWith("#")) {
            tasks = yield task_1.default.find({ user: req.userId, tag: search });
        }
        else {
            tasks = yield task_1.default.find({
                user: req.userId,
                title: { $regex: search, $options: "i" },
            });
        }
        res.json(tasks);
    }
    catch (error) {
        if (error instanceof Error) {
            console.log(error.message);
            res.status(500).json({ message: "Cant get all tasks" });
        }
    }
});
exports.getFilteredUserTasks = getFilteredUserTasks;
const getAllUniqueTags = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const tasks = yield task_1.default.find({ user: req.userId }).distinct("tag");
        res.json(tasks);
    }
    catch (error) {
        if (error instanceof Error) {
            console.log(error.message);
            res.status(500).json({ message: "Cant get all tags" });
        }
    }
});
exports.getAllUniqueTags = getAllUniqueTags;
const create = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const doc = new task_1.default({
            title: req.body.title,
            tag: req.body.tag,
            user: req.userId,
        });
        const task = yield doc.save();
        res.status(200).json(task);
    }
    catch (error) {
        if (error instanceof Error) {
            console.log(error.message);
            res.status(500).json({ message: "Cant create the task" });
        }
    }
});
exports.create = create;
const remove = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const taskId = req.query.taskId;
        yield task_1.default.findByIdAndDelete(taskId);
        res.status(200).json(taskId);
    }
    catch (error) {
        if (error instanceof Error) {
            console.log(error.message);
            res.status(500).json({ message: "Cant remove task" });
        }
    }
});
exports.remove = remove;
