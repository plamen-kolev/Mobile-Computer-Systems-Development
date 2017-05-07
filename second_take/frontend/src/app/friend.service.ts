import { Injectable } from '@angular/core';
import { AuthService } from '../auth/auth.service';
import { environment } from 'environments/environment';

@Injectable()
export class FriendService {

  constructor(private authService: AuthService) {}
  addFriend(id: number): any {

    return this.authService
    .post(`${environment.backendRails}/api/connections`, {user_id: id})
  }

  confirmFriend(connection_id: number, user_id: number): any {
    return this.authService
    .get(`${environment.backendRails}/api/connections/${connection_id}/confirm`)
  }
}
