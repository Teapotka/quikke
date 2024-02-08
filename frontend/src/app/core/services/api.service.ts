import { HttpClient } from "@angular/common/http"
import { Injectable } from "@angular/core"
import { Observable } from "rxjs"
import { environment } from "src/environments/environment"
import { TUserPayload, TAction, TAuthUserResponse, TTaskPayload, TCreateTaskResponse, TGetTasksResponse } from "./api.typing"

@Injectable({ providedIn: "root" })
export class ApiService {
  constructor(private http: HttpClient) {}

  authorizeUser(payload: TUserPayload, action: TAction): Observable<TAuthUserResponse> {
    return this.http.post<TAuthUserResponse>(
      `${environment.apiUrl}/auth/${action}`,
      payload
    )
  }
  deleteTask(taskId: string): Observable<string>{
    const url = new URL(`${environment.apiUrl}/tasks`)
    url.searchParams.append('taskId', taskId)
    const urlString = url.toString()
    return this.http.delete<string>(urlString)
  }
  createTask(payload: TTaskPayload): Observable<TCreateTaskResponse>{
    return this.http.post<TCreateTaskResponse>(
      `${environment.apiUrl}/tasks`,
      payload
    )
  }
  getAllUserTasks():Observable<TGetTasksResponse[]>{
    return this.http.get<TGetTasksResponse[]>(`${environment.apiUrl}/tasks`)
  }
  getAllUserTags():Observable<string[]>{
    return this.http.get<string[]>(`${environment.apiUrl}/tasks/tags`)
  }
  getFilteredTasks(search: string):Observable<TGetTasksResponse[]>{
    const url = new URL(`${environment.apiUrl}/tasks/filtered`)
    url.searchParams.append("search", search)
    const urlString = url.toString()
    return this.http.get<TGetTasksResponse[]>(urlString)
  }

}
