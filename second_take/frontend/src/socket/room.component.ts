import { Component, OnInit } from '@angular/core';
import * as io from 'socket.io-client';
import { Message } from './message';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../auth/auth.service';

@Component({
  selector: 'room',
  styleUrls: ['./room.component.css'],
  templateUrl: './room.component.html'
})
export class RoomComponent implements OnInit{
  email: string = localStorage.getItem("auth_user");
  room: string;
  socket: any;
  server = 'http://localhost:4201';
  messages: Message[] = [];
  body: string;
  recipient: string = "local2@host.com";

  constructor(private route: ActivatedRoute, router: Router){
    if(! localStorage.getItem("auth_user")){
      router.navigate(['/login'])
    }
    this.room = route.snapshot.params['room'];
    this.socket = io(this.server);
    this.socket.emit('join', {email: this.email, room: this.room});
  }

  ngOnInit(){
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
