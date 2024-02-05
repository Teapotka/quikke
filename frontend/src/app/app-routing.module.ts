import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthComponent } from './auth/auth.component';
import { TodoComponent } from './todo/todo.component';

const routes: Routes = [
  {path: 'auth', component: AuthComponent},
  {path: 'todo', component: TodoComponent},
  {path: '**', redirectTo: '/todo'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
