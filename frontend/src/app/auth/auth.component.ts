import { HttpClient } from "@angular/common/http"
import { Component, OnInit } from "@angular/core"
import { FormBuilder, FormControl, FormGroup, Validators } from "@angular/forms"
import { Router } from "@angular/router"

@Component({
  selector: "app-auth",
  templateUrl: "./auth.component.html",
  styleUrls: ["./auth.component.sass"],
})
export class AuthComponent implements OnInit{
  get login(): FormControl {
    return this.form.get("login") as FormControl
  }
  get password(): FormControl {
    return this.form.get("password") as FormControl
  }

  form!: FormGroup
  loginError: string | null = null

  constructor(
    private fb: FormBuilder,
    private http: HttpClient,
    private router: Router,
  ) {}

  ngOnInit(): void {
    this.buildForm()
  }

  buildForm() {
    this.form = this.fb.group({
      login: this.fb.control("", [
        Validators.required,
        Validators.minLength(5),
        Validators.maxLength(25),
      ]),
      password: this.fb.control("", [
        Validators.required,
        Validators.minLength(5),
        Validators.maxLength(25),
      ]),
    })
    this.form.get('login')!.valueChanges.subscribe(() => {
      this.loginError = null;
    });
    this.form.get('password')!.valueChanges.subscribe(() => {
      this.loginError = null;
    });
  }


  
  onSubmit(e: any) {
    e.preventDefault()
    if (this.form.status == "VALID") {
      const { id } = e.submitter
      const { login, password } = this.form.value
      if (id == "login") {
        this.loginUser(login, password)
      }
      if (id == "signup") {
        this.registerUser(login, password)
      }
    }
  }
  loginUser(login: string, password: string) {
    this.http
      .post(`https://quikke.onrender.com/auth/login`, {
        name: login,
        password: password,
      })
      .subscribe({
        next: (data: any) => {
          if ("token" in data) {
            localStorage.setItem("token", data.token)
            this.router.navigate(["/todo"])
          }
        },
        error: (error: any) => {
          console.log(error)
          this.loginError = 'Invalid login or password. Please try again.'
        },
      })
  }
  registerUser(login: string, password: string) {
    this.http
      .post(`https://quikke.onrender.com/auth/register`, {
        name: login,
        password: password,
      })
      .subscribe((data: any) => {
        if ("token" in data) {
          localStorage.setItem("token", data.token)
          this.router.navigate(["/todo"])
        }
      })
  }
}
