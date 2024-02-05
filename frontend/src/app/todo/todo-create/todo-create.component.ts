import { Component } from '@angular/core';

@Component({
  selector: 'app-todo-create',
  templateUrl: './todo-create.component.html',
  styleUrls: ['./todo-create.component.sass']
})
export class TodoCreateComponent {
  title = 'Helo'
  control(e:any){
    if (e.target.className == 'tag'){
      if(e.target.value == ''){
        e.target.value = "#"
      }
      else{
        if(e.target.value[0] != "#")
          e.target.value = '#' +  e.target.value
      }
    }   
  }
}
