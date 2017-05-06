import { Component, OnInit } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { AuthHttp, JwtHelper } from 'angular2-jwt';
import { Response } from '@angular/http';
import { environment } from '../environments/environment';

@Component({
  selector: 'index',
  templateUrl: './index.component.html',
})
export class IndexComponent implements OnInit{

  channels: any;
  auth_user: string = localStorage.getItem('auth_user')
  constructor(public authService: AuthService, private authHttp: AuthHttp) {}

  ngOnInit(){
    this.authHttp.get(environment.backendRails + '/api/connections')
      .subscribe((response) => this.channels = response.json());
    }
}
