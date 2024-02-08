import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthComponent } from './feature/auth/auth.component';
import { TodoComponent } from './feature/todo/todo.component';

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
