import mongoose from "mongoose"

const taskSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  tag: {
    type: String,
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
})

export default mongoose.model("Task", taskSchema, 'tasks')

