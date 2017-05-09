import { Routes } from '@angular/router';
import { RoomComponent } from '../socket/room.component';
import { IndexComponent } from './index.component';
import { LoginComponent } from '../auth/login.component';
import { AddFriendComponent } from '../socket/addfriend.component';
import { RegisterComponent } from 'auth/register.component';

export const routes: Routes = [
  { path: '', component: IndexComponent },
  { path: 'home', component: IndexComponent },
  { path: 'room/:room', component:  RoomComponent },
  { path: 'login', component: LoginComponent },
  { path: 'logout', component: IndexComponent },
  { path: 'meet', component: AddFriendComponent },
  { path: 'register', component: RegisterComponent },
];
