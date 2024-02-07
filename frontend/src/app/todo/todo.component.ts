import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-todo',
  templateUrl: './todo.component.html',
  styleUrls: ['./todo.component.sass']
})
export class TodoComponent implements OnInit {
  // items=Array(10)

  constructor(
    private router: Router,
    private http: HttpClient
  ){}

  todos : any = [{title: '', tag: '', _id:''}]
  search: string = ''

  ngOnInit(): void {
    if(!localStorage.getItem('token')){
      this.router.navigate(['/auth'])
    }
    this.getUserTodos()
  }
  getUserTodos(){
    this.http.get('http://localhost:3000/tasks').subscribe((data)=>{
      this.todos = (data as any[]).reverse()
      console.log(this.todos)
    })
    console.log(this.search)
  }

  filter(){
    console.log("SER",this.search)
    const url = new URL('http://localhost:3000/tasks/filtered')
    url.searchParams.append('search', this.search)
    this.http.get(url.toString()).subscribe((data)=>{
      console.log("DATA", data)
      this.todos = data
    })
  }
}
