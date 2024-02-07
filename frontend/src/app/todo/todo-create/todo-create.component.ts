import { HttpClient } from '@angular/common/http';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, NonNullableFormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-todo-create',
  templateUrl: './todo-create.component.html',
  styleUrls: ['./todo-create.component.sass']
})
export class TodoCreateComponent implements OnInit {
  
  @Output() notificate = new EventEmitter<any>();

  current = 'assets/add.svg'
  selected = 'assets/selected.svg'
  unselected = 'assets/add.svg'

  get title(): FormControl {
    return this.form.get("title") as FormControl
  }
  get tag(): FormControl {
    return this.form.get("tag") as FormControl
  }

  form!: FormGroup

  constructor(
    private fb: NonNullableFormBuilder,
    private http: HttpClient,
  ) {}

  ngOnInit(): void {
    this.buildForm()
  }

  buildForm() {
    this.form = this.fb.group({
      title: this.fb.control("New Task", [
        Validators.required,
        Validators.maxLength(30),
      ]),
      tag: this.fb.control("#tag", [
        Validators.maxLength(11),
      ]),
    })
    this.tag.valueChanges.subscribe(value => {
      this.updateTagControl(value);
    });
  }
  updateTagControl(value: string) {
    let newValue =  `#${value.toLowerCase().replaceAll('#', '')}`
    this.tag.setValue(newValue, { emitEvent: false });
  }

  done(){
    this.current = this.selected
    const requestBody: {title: string, tag?: string} = {
      title: this.title.value.trim()
    }
    const tag = `#${this.tag.value.replace('#', '').trim()}`
    console.log(tag)

    if(this.tag.value != "#"){
      requestBody["tag"] = tag
    }
    this.http.post('http://localhost:3000/tasks', requestBody).subscribe(console.log)
    this.form.reset()
    this.current = this.unselected
    this.notificate.emit()
  }
    
}
