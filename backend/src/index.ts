import dotenv from "dotenv"
import express, { Request, Response } from "express"
import mongoose from "mongoose"
import cors from "cors"
import { taskController, userController } from "./controllers"
import checkAuth from "./utils/checkAuth"
import { loginValidator, registerValidator } from "./validators/auth"
import handleValidationError from "./utils/handleValidationError"
import { taskCreationValidator } from "./validators/task"

dotenv.config()

const app = express()
const port = +process.env.PORT!
const host = process.env.HOST!
const user = process.env.MONGODB_USER
const password = process.env.MONGODB_PASSWORD
const backlog = 10

const connect = `mongodb+srv://${user}:${password}@cluster0.bqbxlwq.mongodb.net/todo`

app.use(express.json())
app.use(cors())

const start = async () => {
  try {
    await mongoose.connect(connect)
    console.log("Database connection succeeded")

    app.listen(port, host, backlog,() => {
      console.log(`[server]: Server is running at http://${host}:${port}`)
    })
  } catch (error) {
    if (error instanceof Error) console.log("Database error: " + error.message)
  }
}

app.post("/auth/register", registerValidator, handleValidationError, userController.register)
app.post("/auth/login", loginValidator,handleValidationError ,userController.login)
app.get("/auth/me", checkAuth , userController.authMe)

app.get("/tasks/", taskController.getAll)
app.get("/tasks/tags", taskController.getAllUniqueTags)
app.post("/tasks/", checkAuth, taskCreationValidator, handleValidationError ,taskController.create)
app.delete("/tasks/:taskId?", checkAuth, taskController.remove)

start()