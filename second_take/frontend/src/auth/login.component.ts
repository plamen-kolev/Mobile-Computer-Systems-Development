import { Component, OnInit } from '@angular/core';
import { AuthService } from './auth.service';
import {Router} from '@angular/router';

@Component({
  selector: 'app-auth',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  email: string;
  password: string;
  alert: string;
  auth_user: string;

  constructor(private authService: AuthService, private router: Router) {}

  ngOnInit() {
    this.auth_user = localStorage.getItem('auth_user');
    if (this.auth_user){
      this.router.navigateByUrl('/');
    }
  }

  login() : void {
    this.authService.login(this.email, this.password)
      .subscribe(
        (data) => {
          // save the token in local storage
          let token = data.jwt;
          localStorage.setItem('token', token)
          localStorage.setItem('auth_user', this.email)
          this.authService.change$.emit('login');
          this.router.navigateByUrl('/');
        },
        (error) => {
          this.alert = "Invalid email or password";
          this.alert = error
        }
      );

  }

}
