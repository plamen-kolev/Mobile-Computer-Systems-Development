import { Component } from '@angular/core';
import { AuthService } from '../auth/auth.service';

@Component({
  selector: 'index',
  templateUrl: './index.component.html',
})
export class IndexComponent {

  channels: string[];
  constructor(public authService: AuthService) {}
}
