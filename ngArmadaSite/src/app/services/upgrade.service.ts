import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { Upgrade } from '../models/upgrade';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UpgradeService {

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + '/api/upgrade';

  constructor(private http: HttpClient) { }

  index() {
    return this.http.get<Upgrade[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('UpgradeService.index(): Error retrieving list of all upgrades');
      })
    );
  }

  show(id: number) {
    return this.http.get<Upgrade>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('UpgradeService.show(): Error retrieving single upgrade instance');
      })
    );
  }
}
