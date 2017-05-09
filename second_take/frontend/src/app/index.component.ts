import { Component, OnInit } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { AuthHttp, JwtHelper } from 'angular2-jwt';
import { Response } from '@angular/http';
import { environment } from '../environments/environment';
import { FriendService } from './friend.service';
import { User } from './user';

@Component({
  selector: 'index',
  templateUrl: './index.component.html',
  styleUrls: ['./index.component.css']
})
export class IndexComponent implements OnInit{

  channels: any;
  users: User[];
  auth_user: string = localStorage.getItem('auth_user')
  constructor(public authService: AuthService, private authHttp: AuthHttp, private friendService: FriendService) {
    this.authService.change$.subscribe(event => {
      if(event === 'login'){
        this.auth_user = localStorage.getItem('auth_user');
      } else {
        this.auth_user = null;
      }
    });

  }

  ngOnInit(){
    this.users = [];
    if(this.auth_user){
      this.authHttp.get(environment.backendRails + '/api/connections')
      .subscribe((response) => {
        this.channels = response.json()
        this.users.push(response.json())
        console.log(this.channels);
      });
    }

  }

  addFriend(id) {
    this.friendService.addFriend(id)
      .subscribe( (val) => {
          console.log(val.json().channel);
          var user = this.users.find(user => user.id == id);
          user.status = "pending";
          user.channel = val.json().channel;
        });

  }
  //
  confirmFriend(connection_id, user_id, channel) {
    this.friendService.confirmFriend(connection_id, user_id)
    .subscribe( (val) => {
        var channel = this.channels.find(c => c.channel == connection_id);
        console.log(channel);
        channel.status = "confirmed";
        channel.confirmed = true;
    });
  }

}
