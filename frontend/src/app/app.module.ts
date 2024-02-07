import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HTTP_INTERCEPTORS, HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { TodoComponent } from './todo/todo.component';
import { AuthComponent } from './auth/auth.component';
import { TodoElementComponent } from './todo/todo-element/todo-element.component';
import { TodoCreateComponent } from './todo/todo-create/todo-create.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AuthInterceptor } from './auth.interceptor';
import { TodoHeaderComponent } from './todo/todo-header/todo-header.component';

@NgModule({
  declarations: [
    AppComponent,
    TodoComponent,
    AuthComponent,
    TodoElementComponent,
    TodoCreateComponent,
    TodoHeaderComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: AuthInterceptor,
      multi: true
    },
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
