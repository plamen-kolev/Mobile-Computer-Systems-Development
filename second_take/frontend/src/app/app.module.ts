import { BrowserModule } from '@angular/platform-browser';
import { provideAuth, AuthHttp, AuthConfig } from 'angular2-jwt';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { routes } from './routes';
import { AppComponent } from './app.component';
import { RoomComponent} from '../socket/room.component';
import { IndexComponent } from './index.component';
import { HttpModule, Http, RequestOptions } from '@angular/http';
import { AuthService } from '../auth/auth.service';
import { LoginComponent } from '../auth/login.component';
import { AddFriendComponent } from '../socket/addfriend.component';

export function authHttpServiceFactory(http: Http, options: RequestOptions) {
  return new AuthHttp(new AuthConfig(), http, options);
}

@NgModule({
  declarations: [
    AppComponent,
    RoomComponent,
    IndexComponent,
    LoginComponent,
    AddFriendComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    RouterModule.forRoot(routes)
  ],
  providers: [
    AuthService,
    {
      provide: AuthHttp,
      useFactory: authHttpServiceFactory,
      deps: [Http, RequestOptions]
    }

  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
