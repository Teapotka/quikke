import mongoose from "mongoose"

export interface TUser {
  login: {
    type: String
    unique: Boolean
    required: Boolean
  }
  passwordHash: {
    type: String
    required: Boolean
  }
}

export interface UserDocument extends TUser, mongoose.Document {
  createdAt: Date
  updatedAt: Date
  _doc?: any
}

const userSchema = new mongoose.Schema<UserDocument>({
  login: {
    type: String,
    unique: true,
    required: true,
  },
  passwordHash: {
    type: String,
    required: true,
  },
})

export default mongoose.model("User", userSchema, "users")
