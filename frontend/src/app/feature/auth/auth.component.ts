import { HttpClient, HttpErrorResponse } from "@angular/common/http"
import { Component, OnInit } from "@angular/core"
import { FormBuilder, FormControl, FormGroup, Validators } from "@angular/forms"
import { Router } from "@angular/router"
import { ApiService } from "../../core/services/api.service"
import { TAction, TUserPayload } from "src/app/core/services/api.typing"

@Component({
  selector: "app-auth",
  templateUrl: "./auth.component.html",
  styleUrls: ["./auth.component.sass"],
  providers: [ApiService],
})
export class AuthComponent implements OnInit {
  get login(): FormControl {
    return this.form.get("login") as FormControl
  }
  get password(): FormControl {
    return this.form.get("password") as FormControl
  }

  form!: FormGroup
  loginError: string | null = null
  formErrorMessages = {
    required: "This field is required.",
    minlength: "Must be at least 5 characters long.",
    maxlength: "Cannot be more than 25 characters long.",
    badLogin: "Invalid login or password. Please try again.",
    bagRegister: "This login name is occupied. Please try again."
  };


  constructor(
    private fb: FormBuilder,
    private router: Router,
    private api: ApiService
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
    this.form.valueChanges.subscribe(() => {
        this.loginError = null
    })
  }

  onSubmit(e: any) {
    if (this.form.status == "VALID") {
      const id = e.submitter.id as TAction
      const payload = this.form.value as TUserPayload
      this.api.authorizeUser(payload, id).subscribe({
            next: (data) => {
              if ("token" in data) {
                localStorage.setItem("token", data.token)
                this.router.navigate(["/todo"])
              }
            },
            error: (error: HttpErrorResponse) => {
              console.log(error)
              if(id == "login")
                this.loginError = this.formErrorMessages.badLogin
              else
                this.loginError = this.formErrorMessages.bagRegister
            },
          })
    }
  }
}
