import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-todo-element',
  templateUrl: './todo-element.component.html',
  styleUrls: ['./todo-element.component.sass']
})
export class TodoElementComponent {
  @Input() title: string = ''
  @Input() tag: string = ''
}
