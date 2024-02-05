import { Request, Response, response } from "express"
import taskModel from "../models/task"
import { AuthenticatedRequest } from "../utils/checkAuth"

export const getAll = async (req: Request, res: Response) => {
  try {
    console.log("hello")
    const tasks = await taskModel.find()

    res.json(tasks)
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.message)
      res.status(500).json({ message: "Cant get all tasks" })
    }
  }
}

export const getAllUniqueTags = async (req: Request, res: Response) => {
    try {
      console.log("hello")
      const tasks = await taskModel.distinct('tag')
  
      res.json(tasks)
    } catch (error) {
      if (error instanceof Error) {
        console.log(error.message)
        res.status(500).json({ message: "Cant get all tags" })
      }
    }
  }

export const create = async (req: AuthenticatedRequest, res: Response) => {
  try {
    const doc = new taskModel({
      title: req.body.title,
      tag: req.body.tag,
      user: req.userId,
    })

    const task = await doc.save()
    res.status(200).json(task)
  } catch (error) {
    if (error instanceof Error) {
      console.log(error.message)
      res.status(500).json({ message: "Cant create the task" })
    }
  }
}

export const remove = async (req: AuthenticatedRequest, res: Response) => {
    try {
        const taskId = req.query.taskId
        console.log(taskId)
        await taskModel.findByIdAndDelete(taskId)
        res.status(200).json(taskId)
    } catch (error) {
        if (error instanceof Error) {
          console.log(error.message)
          res.status(500).json({ message: "Cant remove task" })
        }
      }
}