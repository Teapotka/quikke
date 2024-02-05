import userModel, { UserDocument } from "../models/user"
import jwt from "jsonwebtoken"
import bcrypt from "bcrypt"
import { Request, Response } from "express"
import { AuthenticatedRequest } from "../utils/checkAuth"

const sign = (user: UserDocument) => {
  return jwt.sign(
    {
      _id: user._id,
    },
    "quikke",
    {
      expiresIn: "30d",
    }
  )
}

export const register = async (req: Request, res: Response) => {
  try {
    const { name, password } = req.body
    const salt = await bcrypt.genSalt(10)
    const passwordHash = await bcrypt.hash(password, salt)

    const doc = new userModel({
      name: name,
      passwordHash: passwordHash,
    })

    const user = await doc.save()

    const token = sign(user)

    const userInfo = user._doc
    res.status(200).json({ userInfo, token })
  } catch (error) {
    if (error instanceof Error) {
      res.status(500).json({ success: false, error: error.message })
    }
  }
}

export const login = async (req: Request, res: Response) => {
  try {
    const { name, password } = req.body
    const user = await userModel.findOne({ name })

    if (!user) {
      return res.status(404).json({ message: "User not found" })
    }

    const isValid = await bcrypt.compare(password, user._doc.passwordHash)

    console.log(isValid)

    if (!isValid) {
      return res.status(400).json({ message: "Wrong data" })
    }

    const token = sign(user)
    const userInfo = user._doc

    res.status(200).json({ userInfo, token })
  } catch (err) {
    if (err instanceof Error) {
      console.log(err.message)
      res.status(500).json({ message: err.message })
    }
  }
}

export const authMe = async (req: AuthenticatedRequest, res: Response)=> {
    try{
        const user = await userModel.findById(req.userId)
        if(!user)
        {
            console.log('here')
            return res.status(404).json({message: 'User is not found'})
        }
        const userInfo = user._doc
        res.status(200).json({userInfo, token: req.userId})
    }catch (err) {
        res.status(500).json({message: 'Auth processing error'})
    }
}