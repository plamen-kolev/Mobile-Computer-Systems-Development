import { Component, OnInit, ElementRef, ViewChild } from '@angular/core';
import * as io from 'socket.io-client';
import { Message } from './message';
import { ActivatedRoute, Router } from '@angular/router';
import { AuthService } from '../auth/auth.service';

@Component({
  selector: 'room',
  styleUrls: ['./room.component.css'],
  templateUrl: './room.component.html'
})

export class RoomComponent implements OnInit {

  @ViewChild('scroll') private scrollContainer: ElementRef;

  email: string;
  room: string;
  socket: any;
  server = 'http://localhost:4201';
  messages: Message[] = [];
  body: string;
  recipient: string;
  height: number;
  new_message: Message;

  constructor(private route: ActivatedRoute, private router: Router, private authService: AuthService){
    this.email = localStorage.getItem("auth_user");
    this.room = this.route.snapshot.params['room'];
    console.log(this.email);
    this.authService.get(localStorage.getItem('backend_url') + '/api/connections/' + this.room)
      .subscribe((response) =>
      this.recipient = response.json().recipient
    );

    // socket io connection
    this.socket = io(this.server);
    this.socket.emit('join', {email: this.email, room: this.room});
    console.log(this.recipient);
  }

  ngOnInit(){
    // redirect if user not logged in
    if(! localStorage.getItem("auth_user")){
      this.router.navigate(['/login'])
    }

    // grab all current messages for that channel
    this.authService.get(localStorage.getItem('backend_url') + '/api/connections/' + this.room + '/messages')
      .subscribe((response) => this.messages = response.json());

    this.socket.on('chat', function(message){
      console.log(message.id);
      // upon notification with message id, ask the webserver what the message is, if the right user is asking,
      // server will allow message to be viewed

      this.authService.get(localStorage.getItem('backend_url') + '/api/connections/' + this.room + '/messages/' + message.id)
        .subscribe(response => {
          this.messages[this.messages.length] = this._addMessageFromResponse(response);
        });

      // message = new Message(this.room, message.sender, this.recipient, message.body, message.date);
      // this.messages[this.messages.length] = message;
    }.bind(this));
  }


  scrollToBottom(): void {
    try {
        var result = this.scrollContainer.nativeElement.scrollTop = this.scrollContainer.nativeElement.scrollHeight;
    } catch(err) {
      console.log(err);
    }
  }

  sendMessage(){
    if (!this.body){
      return;
    }

    // first, the message gets sent to the server
    this.authService.post(localStorage.getItem('backend_url') + '/api/connections/' + this.room + '/messages/send', {body: this.body})
    .subscribe( response => {
      this.messages[this.messages.length] = this._addMessageFromResponse(response);
      // then send it to javascipt server

      var message = {
        // sender: this.email,
        // recipient: this.recipient,
        // body: this.body,
        id: response.json().id
      }

      this.socket.emit('chat', message);
      this.body = "";
    });
  }

  // add message to message queue when sender or receiver sends
  _addMessageFromResponse(response): Message {
    return new Message(
      response.json().room,
      response.json().sender,
      response.json().recipient,
      response.json().body,
      new Date().toString()
    );
  }
}
