import { Component, OnInit, EventEmitter, Output } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { environment } from '../environments/environment';
import {FormControl} from '@angular/forms';
import { Subject } from "rxjs/Subject";
import { FriendService } from './friend.service';
import { User } from './user';
import "rxjs/add/operator/debounceTime";
import "rxjs/add/operator/distinctUntilChanged";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  auth_user: string;
  // searchTerm: string;
  users: User[];
  showSearchResults: boolean;
  searchUpdated: Subject<string>;

  @Output() searchChangeEmitter: EventEmitter<any> = new EventEmitter<any>();

  constructor(public authService: AuthService, private friendService: FriendService) {}

  ngOnInit() {
    this.searchUpdated = new Subject<string>();

    this.searchChangeEmitter = <any>this.searchUpdated.asObservable()
         .debounceTime(500)
          .distinctUntilChanged().subscribe((val) => {
            console.log(val);
            if (val){
              this.authService.
              get(environment.backendRails + '/api/users/' + val)
              .subscribe((val) => this.users = val.json());
              this.showSearchResults = true;
            } else {
              this.showSearchResults = false;
            }
          });

    this.auth_user = localStorage.getItem('auth_user');
  }

  onSearchChange(value: string) {
    this.searchUpdated.next(value);
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
  confirmFriend(connection_id, user_id) {
    this.friendService.confirmFriend(connection_id, user_id)
    .subscribe( (val) => {
        console.log(val.json().channel);
        var user = this.users.find(user => user.id == user_id);
        user.status = "confirmed";
    });
  }
}
