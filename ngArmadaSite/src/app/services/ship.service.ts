import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Ship } from '../models/ship';

@Injectable({
  providedIn: 'root'
})
export class ShipService {

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + '/api/ship';

  constructor(private http: HttpClient) { }

  index() {
    return this.http.get<Ship[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ShipService.index(): Error retrieving list of all ships');
      })
    );
  }

  show(id: number) {
    return this.http.get<Ship>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ShipService.show(): Error retrieving single ship instance');
      })
    );
  }
}
