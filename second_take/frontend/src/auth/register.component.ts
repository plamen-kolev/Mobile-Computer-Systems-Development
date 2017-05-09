import { Component, OnInit } from '@angular/core';
import { AuthService } from './auth.service';
import {Router} from '@angular/router';
import { Http } from '@angular/http';
import { environment } from 'environments/environment';

@Component({
  selector: 'app-auth',
  templateUrl: './register.component.html',
  // styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  email: string;
  password: string;
  password_confirmation
  alert: string;
  auth_user: string;

  constructor(private authService: AuthService, private router: Router, private http: Http) {}

  ngOnInit() {
    this.auth_user = localStorage.getItem('auth_user');
    if (this.auth_user){
      this.router.navigateByUrl('/');
    }
  }

  register() {
    this.http.post(`${environment.backendRails}/users`,
      {
        user: {
          email: this.email,
          password: this.password,
          password_confirmation: this.password_confirmation,
        }
    }).subscribe((val) => {
      this.authService.login(this.email, this.password);
      this.router.navigateByUrl('/');
      console.log("asd");
    })
  }

}
