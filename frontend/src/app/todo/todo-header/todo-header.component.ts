import { HttpClient } from '@angular/common/http';
import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-todo-header',
  templateUrl: './todo-header.component.html',
  styleUrls: ['./todo-header.component.sass']
})
export class TodoHeaderComponent implements OnInit {
  @Output() filter = new EventEmitter<any>();
  @Output() searchStringChange = new EventEmitter<string>(); // Output property and event emitter
  @Input() searchString = "";

  get search():FormControl{
    return this.form.get('search') as FormControl
  }

  constructor(
    private fb: FormBuilder,
    private http: HttpClient
  ){}

  form!: FormGroup
  tapped = false
  tags:any = []

  ngOnInit(): void {
    this.buildForm()
    this.getAllUserTags()
  }

  buildForm(){
    this.form = this.fb.group({
      search: this.fb.control('')
    })
    this.search.valueChanges.subscribe((data)=>{
        if(this.tapped){
          document.querySelectorAll('.hash.active').forEach((tag)=>{
            tag.classList.remove('active')
          })
        }
    })
  }

  getAllUserTags(){
    this.http.get('http://localhost:3000/tasks/tags').subscribe((data)=>{
      console.log(data)
      this.tags = data
    })
  }

  toggle(){
    document.querySelector('.filter-container')?.classList.toggle('tapped')
    this.tapped = !this.tapped
  }

  find(){
    this.searchString = this.search.value
    console.log(this.searchString)
    this.searchStringChange.emit(this.searchString)
    this.filter.emit()
  }

  fill(value:string, e:any){
    document.querySelectorAll('.hash.active').forEach((tag)=>{
      tag.classList.remove('active')
    })
    this.search.setValue(value)
    e.target.classList.add('active')
  }
}
