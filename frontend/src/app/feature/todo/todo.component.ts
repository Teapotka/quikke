import { Component, OnInit } from "@angular/core"
import { FormBuilder, FormControl, FormGroup } from "@angular/forms"
import { Router } from "@angular/router"
import { ApiService } from "src/app/core/services/api.service"
import { TGetTasksResponse } from "src/app/core/services/api.typing"

@Component({
  selector: "app-todo",
  templateUrl: "./todo.component.html",
  styleUrls: ["./todo.component.sass"],
  providers: [ApiService],
})
export class TodoComponent implements OnInit {
  get search(): FormControl {
    return this.form.get("search") as FormControl
  }
  constructor(
    private router: Router,
    private api: ApiService,
    private fb: FormBuilder
  ) {}

  //Datas
  todos: TGetTasksResponse[] = []
  tags: string[] = []

  form!: FormGroup

  //States
  isTapped: boolean = false
  isActive: boolean = false

  ngOnInit(): void {
    if (!localStorage.getItem("token")) {
      this.router.navigate(["/auth"])
    }
    this.buildForm()
    this.getUserTodos()
    this.getAllUserTags()
  }

  buildForm() {
    this.form = this.fb.group({
      search: this.fb.control(""),
    })
    this.search.valueChanges.subscribe(() => {
      this.stopFilter(true)
      if (this.isTapped) {
        this.clearHash()
      }
    })
  }

  getUserTodos() {
    this.api.getAllUserTasks().subscribe((data) => {
      this.todos = data.reverse()
    })
  }

  getAllUserTags() {
    this.api.getAllUserTags().subscribe((data) => {
      this.tags = data.slice(0, 5)
    })
  }

  filterTodos() {
    this.startFilter()
    const search = this.search.value.trim()
    this.api.getFilteredTasks(search).subscribe((data) => {
      this.todos = data.reverse()
    })
  }

  toggle() {
    document.querySelector(".filter-container")?.classList.toggle("active-filter")
    this.isTapped = !this.isTapped
  }
  
  clearHash() {
    document.querySelectorAll(".hash.active-hash").forEach((tag) => {
      tag.classList.remove("active-hash")
    })
  }

  chooseHash(value: string, e: any) {
    document.querySelectorAll(".hash.active-hash").forEach((tag) => {
      tag.classList.remove("active-hash")
    })
    this.search.setValue(value)
    e.target.classList.add("active-hash")
  }

  startFilter() {
    this.isActive = true
    const search = document.querySelector(".search")!.classList
    if (!search.contains("active-search")) {
      search.add("active-search")
    }
  }

  stopFilter(reload = false) {
    this.isActive = false
    const search = document.querySelector(".search")!.classList
    if (search.contains("active-search")) {
      search.remove("active-search")
    }
    if (reload) {
      this.getUserTodos()
    }
  }

  taskChange(action: "add" | "remove") {
    this.getAllUserTags()
    if (action == "remove" && this.isActive) {
      this.filterTodos()
    } else {
      if (this.isActive) {
        this.stopFilter()
      }
      this.getUserTodos()
    }
  }
}
