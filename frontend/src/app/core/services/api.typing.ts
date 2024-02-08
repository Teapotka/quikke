export type TAuthUserResponse = {
  userInfo: {
    _id: string
    login: string
    passwordHash: string
    __v: number
  }
  token: string
}

export type TUserPayload = {
  login: string
  password: string
}

export type TAction = "login" | "register"

export type TTaskPayload = {
  title: string
  tag?: string
}

export type TCreateTaskResponse = {
  title: string
  tag?: string
  user: string
  _id: string
  __v: number
}

export type TGetTasksResponse = {
  title: string
  tag?: string
  user: string
  _id: string
  __v: number
}
