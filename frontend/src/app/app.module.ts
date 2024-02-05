import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { TodoComponent } from './todo/todo.component';
import { AuthComponent } from './auth/auth.component';
import { TodoElementComponent } from './todo/todo-element/todo-element.component';
import { TodoCreateComponent } from './todo/todo-create/todo-create.component';

@NgModule({
  declarations: [
    AppComponent,
    TodoComponent,
    AuthComponent,
    TodoElementComponent,
    TodoCreateComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
