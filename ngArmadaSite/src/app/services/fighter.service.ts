import { environment } from './../../environments/environment';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Fighter } from '../models/fighter';
import { throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class FighterService {

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + '/api/fighter';

  constructor(private http: HttpClient) { }

  index() {
    return this.http.get<Fighter[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('FighterService.index(): Error retrieving list of all fighters');
      })
    );
  }

  show(id: number) {
    return this.http.get<Fighter>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('FighterService.show(): Error retrieving single fighter instance');
      })
    );
  }
}
