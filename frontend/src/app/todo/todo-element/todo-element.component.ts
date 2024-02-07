import { HttpClient } from '@angular/common/http';
import { Component, EventEmitter, Input, Output } from '@angular/core';

@Component({
  selector: 'app-todo-element',
  templateUrl: './todo-element.component.html',
  styleUrls: ['./todo-element.component.sass']
})
export class TodoElementComponent {
  @Input() title: string = ''
  @Input() tag: string = ''
  @Input() id: string = ''

  @Output() notificate = new EventEmitter<any>();

  current = 'assets/unselected.svg'
  selected = 'assets/selected.svg'

  constructor(
    private http: HttpClient
  ){}

  done(){
    this.current = this.selected
    console.log(this.id)
    this.http.delete(`http://localhost:3000/tasks?taskId=${this.id}`).subscribe((data)=>{
      console.log(data)
      this.notificate.emit()
    })
  }

}
