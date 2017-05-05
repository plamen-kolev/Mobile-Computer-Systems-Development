import { Routes } from '@angular/router';
import { RoomComponent } from '../socket/room.component';
import { IndexComponent } from './index.component';
import { LoginComponent } from '../auth/login.component';
import { AddFriendComponent } from '../socket/addfriend.component';

export const routes: Routes = [
  { path: '', component: IndexComponent },
  { path: 'room/:recipient/:room', component:  RoomComponent },
  { path: 'login', component: LoginComponent },
  { path: 'logout', component: IndexComponent },
  { path: 'meet', component: AddFriendComponent }
];
