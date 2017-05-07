import { Component, OnInit } from '@angular/core';
import { AuthService } from '../auth/auth.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  auth_user: string;

  constructor(public authService: AuthService) {}
  ngOnInit() {
    this.auth_user = localStorage.getItem('auth_user');
  }
}
