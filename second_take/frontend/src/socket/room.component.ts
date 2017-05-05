import { Component, OnInit } from '@angular/core';
import * as io from 'socket.io-client';
import { Message } from './message';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../auth/auth.service';
import { BehaviorSubject } from 'rxjs';

@Component({
  selector: 'room',
  styleUrls: ['./room.component.css'],
  templateUrl: './room.component.html'
})

export class RoomComponent implements OnInit {
  email: string = localStorage.getItem("auth_user");
  room: string;
  socket: any;
  server = 'http://localhost:4201';
  messages: Message[] = [];
  body: string;
  recipient: string;
  height: number;


  constructor(private route: ActivatedRoute, private router: Router, private authService: AuthService){
    this.room = this.route.snapshot.params['room'];
    this.recipient = this.route.snapshot.params['recipient'];
    this.height = new BehaviorSubject(window.innerHeight).value;

    // socket io connection
    this.socket = io(this.server);
    this.socket.emit('join', {email: this.email, room: this.room});
  }

  ngOnInit(){
    // redirect if user not logged in
    if(! localStorage.getItem("auth_user")){
      this.router.navigate(['/login'])
    }

    // grab all current messages for that channel
    this.authService.get(localStorage.getItem('backend_url') + '/api/connections/' + this.room)
      .subscribe((response) => this.messages = response.json());

    console.log(this.messages);

    this.socket.on('chat', function(message){
      console.log(message);
      message = new Message(this.room, message.sender, this.recipient, message.body, message.date);
      this.messages[this.messages.length] = message;
      console.log(this.messages);
    }.bind(this));
  }

  sendMessage(){

    this.socket.emit('chat', {
      sender: this.email,
      recipient: this.recipient,
      body: this.body
    });
  }


}
