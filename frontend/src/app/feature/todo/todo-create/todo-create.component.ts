import { HttpClient } from '@angular/common/http';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, NonNullableFormBuilder, Validators } from '@angular/forms';
import { ApiService } from 'src/app/core/services/api.service';
import { TTaskPayload } from 'src/app/core/services/api.typing';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-todo-create',
  templateUrl: './todo-create.component.html',
  styleUrls: ['./todo-create.component.sass'],
  providers: [
    ApiService
  ]
})
export class TodoCreateComponent implements OnInit {
  
  @Output() notificate = new EventEmitter();

  get title(): FormControl {
    return this.form.get("title") as FormControl
  }
  get tag(): FormControl {
    return this.form.get("tag") as FormControl
  }

  form!: FormGroup

  constructor(
    private fb: NonNullableFormBuilder,
    private api: ApiService,
  ) {}

  ngOnInit(): void {
    this.buildForm()
  }

  buildForm(): void {
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
    if(this.form.valid){
      const requestBody: TTaskPayload = {
        title: this.title.value.trim()
      }
      const tag = `#${this.tag.value.replace('#', '').trim()}`
  
      if(this.tag.value != "#"){
        requestBody["tag"] = tag
      }
      this.form.reset()
      this.api.createTask(requestBody).subscribe((data)=>{
        this.notificate.emit()
      })
    }
  }
}
