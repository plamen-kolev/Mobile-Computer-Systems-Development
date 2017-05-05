import { Component, Input, Output, OnInit, EventEmitter } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { Http } from '@angular/http';

@Component({
  selector: 'emoticons',
  styleUrls: ['./emoticon.component.css'],
  templateUrl: './emoticon.component.html'
})

export class EmoticonComponent implements OnInit {

  // @Input()
  @Input('karma') karma: number;
  @Input() body: string;

  @Output() bodyChange = new EventEmitter();

  showRude: boolean;
  showDefault: boolean;
  rude: Emoticon[];
  default: Emoticon[];
  backend_url: string = localStorage.getItem('backend_url')

  constructor(private http: Http){
    this.showRude = false;
    this.showDefault = false;
    this.body = "";
  }

  ngOnInit() {

    this.http.get(localStorage.getItem('backend_url') + '/api/emoticons/rude')
      .subscribe((response) => {
        this.rude = <Emoticon[]> response.json()
      });

    this.http.get(localStorage.getItem('backend_url') + '/api/emoticons/default')
        .subscribe((response) => this.default = response.json());
  }

  toggleRude() {
    if(this.showRude){
      this.showDefault = false;
      this.showRude = false;
    } else {
      this.showDefault = false;
      this.showRude = true;
    }
  }

  toggleDefault() {
    if(this.showDefault){
      this.showDefault = false;
      this.showRude = false;
    } else {
      this.showDefault = true;
      this.showRude = false;
    }
  }

  insert(image) {
    this.body += "<img src='" + image.url + "'/>";
    this.bodyChange.next(this.body);
  }

  insertRude(image) {
    this.insert(image);

  }
}

export class Emoticon {
  url: string;
  points: number;
}
