import { Component, OnInit } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { AuthHttp, JwtHelper } from 'angular2-jwt';
import { Response } from '@angular/http';

@Component({
  selector: 'index',
  templateUrl: './index.component.html',
})
export class IndexComponent implements OnInit{

  channels: any;
  auth_user: string = localStorage.getItem('auth_user')
  constructor(public authService: AuthService, private authHttp: AuthHttp) {}

  ngOnInit(){
    this.authHttp.get(localStorage.getItem('backend_url') + '/api/connections')
      .subscribe(
        data => this.channels = data,
        err => console.log(err),
      );
    console.log(this.channels);
  }
}
