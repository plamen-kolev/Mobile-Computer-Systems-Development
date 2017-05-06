import { Injectable } from '@angular/core';
import { Http, Response, RequestOptions, Headers } from '@angular/http';
// import { Observable } from 'rxjs/Observable';
// import { Product } from '../product/product';
import { AuthHttp, JwtHelper } from 'angular2-jwt';
import { environment } from '../environments/environment';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
import { Observable } from 'rxjs/Observable';

@Injectable()
export class AuthService {
  email: string;
  password: string;
  header: Headers = new Headers();

  constructor(private http: Http, private authHttp: AuthHttp) {
    this.header.append('Content-Type', 'application/json');
  }

  get(url) {
    return this.authHttp.get(url);
  }

  post(url, data) {
    var response = null;
    return this.authHttp.post(url, JSON.stringify(data), { headers: this.header })
  }

  logout(): void{
    console.log("triggered logout");
    localStorage.removeItem('auth_user')
    localStorage.removeItem('token');
  }

  login(email:string, password: string): Observable<any> {
    var result: boolean = true;
    this.email = email;
    this.password = password;
    let options: RequestOptions = new RequestOptions({
      headers: new Headers({ 'Content-Type': 'application/json' })
    });
    return this.http
      .post(environment.backendRails + '/api/auth',
      JSON.stringify({ auth: {'email': this.email, 'password': this.password }}),
      options)
      .map((response: Response) => response.json(), (err) => console.log(err))
  }
}
