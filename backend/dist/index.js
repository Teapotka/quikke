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
const dotenv_1 = __importDefault(require("dotenv"));
const express_1 = __importDefault(require("express"));
const mongoose_1 = __importDefault(require("mongoose"));
const cors_1 = __importDefault(require("cors"));
const controllers_1 = require("./controllers");
const checkAuth_1 = __importDefault(require("./utils/checkAuth"));
const auth_1 = require("./validators/auth");
const handleValidationError_1 = __importDefault(require("./utils/handleValidationError"));
const task_1 = require("./validators/task");
dotenv_1.default.config();
const app = (0, express_1.default)();
const port = +process.env.PORT;
const host = process.env.HOST;
const user = process.env.MONGODB_USER;
const password = process.env.MONGODB_PASSWORD;
const backlog = 10;
const connect = `mongodb+srv://${user}:${password}@cluster0.bqbxlwq.mongodb.net/todo`;
app.use(express_1.default.json());
app.use((0, cors_1.default)());
const start = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        yield mongoose_1.default.connect(connect);
        console.log("Database connection succeeded");
        app.listen(port, host, backlog, () => {
            console.log(`[server]: Server is running at http://${host}:${port}`);
        });
    }
    catch (error) {
        if (error instanceof Error)
            console.log("Database error: " + error.message);
    }
});
app.post("/auth/register", auth_1.registerValidator, handleValidationError_1.default, controllers_1.userController.register);
app.post("/auth/login", auth_1.loginValidator, handleValidationError_1.default, controllers_1.userController.login);
app.get("/auth/me", checkAuth_1.default, controllers_1.userController.authMe);
app.get("/tasks/", checkAuth_1.default, controllers_1.taskController.getAllUsersTasks);
app.get("/tasks/tags", checkAuth_1.default, controllers_1.taskController.getAllUniqueTags);
app.get("/tasks/filtered/:search?", checkAuth_1.default, controllers_1.taskController.getFilteredUserTasks);
app.post("/tasks/", checkAuth_1.default, task_1.taskCreationValidator, handleValidationError_1.default, controllers_1.taskController.create);
app.delete("/tasks/:taskId?", checkAuth_1.default, controllers_1.taskController.remove);
start();
