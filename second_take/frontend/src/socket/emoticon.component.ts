import { Component, Input, Output, OnInit, EventEmitter } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { Http } from '@angular/http';
import { environment } from '../environments/environment';

@Component({
  selector: 'emoticons',
  styleUrls: ['./emoticon.component.css'],
  templateUrl: './emoticon.component.html'
})
export class EmoticonComponent implements OnInit {

  // @Input()
  @Input('karma') karma: number;
  @Input() body: string;
  @Input('room') room: string;

  @Output() karmaChange = new EventEmitter();
  @Output() bodyChange = new EventEmitter();

  showRude: boolean;
  showDefault: boolean;
  rude: Emoticon[];
  default: string[];
  backendRails: string;

  constructor(private http: Http, private authService: AuthService){
    this.showRude = false;
    this.showDefault = false;
    this.body = "";
    this.backendRails = environment.backendRails;
  }

  ngOnInit() {}

  toggleRude() {
    if(this.showRude){
      this.showDefault = false;
      this.showRude = false;
    } else {

      // init rude if null
      if (! this.rude){
        this.http.get(this.backendRails + '/api/emoticons/rude')
          .subscribe((response) => {
            this.rude = <Emoticon[]> response.json()
        });
      }

      this.showDefault = false;
      this.showRude = true;
    }
  }

  toggleDefault() {
    if(this.showDefault){
      this.showDefault = false;
      this.showRude = false;
    } else {

      // init rude if null
      if (! this.default){
        this.http.get(this.backendRails + '/api/emoticons/default')
            .subscribe((response) =>  this.default = response.json());
      }

      this.showDefault = true;
      this.showRude = false;
    }
  }

  insert(code) {
    this.body += code;
    this.bodyChange.next(this.body);
  }

  insertRude(code) {

    this.authService.post(this.backendRails + '/api/connections/' + this.room + '/send_rude',
    {emoticon: code})
    .subscribe( response => {
      this.insert(code);
      this.karmaChange.next(response.json().karma);
    });
  }
}

export class Emoticon {
  url: string;
  code: string;
  points: number;
}
