import {Subject} from 'rxjs/Subject';
import {Observable} from 'rxjs/Observable';
import * as io from 'socket.io-client';

export class ChatService {
  private url:string = "http://localhost:3000"
  private socket;

  constructor(){
    this.socket = io(this.url);
  }

  sendMessage(message){
    this.socket.emit('add-message', message);
  }

  getMessage(){
    let observable = new Observable(observer => {
      this.socket.on('message', (data) => {
        observer.next(data);
      });

      return () => {
        this.socket.disconnect();
      };
    });

    return observable;
  }
}
