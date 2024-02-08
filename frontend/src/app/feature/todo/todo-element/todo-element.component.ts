import { Component, EventEmitter, Input, Output } from '@angular/core';
import { ApiService } from 'src/app/core/services/api.service';

@Component({
  selector: 'app-todo-element',
  templateUrl: './todo-element.component.html',
  styleUrls: ['./todo-element.component.sass'],
  providers: [
    ApiService
  ]
})
export class TodoElementComponent {
  @Input() title: string = ''
  @Input() tag?: string = ''
  @Input() id: string = ''

  @Output() notificate = new EventEmitter();

  current = 'assets/unselected.svg'
  selected = 'assets/selected.svg'

  constructor(
    private api: ApiService
  ){}

  done(){
    this.current = this.selected
    this.api.deleteTask(this.id).subscribe((data)=>{
      this.notificate.emit()
    })
  }

}
