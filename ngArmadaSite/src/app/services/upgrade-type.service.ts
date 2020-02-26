import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { UpgradeType } from '../models/upgrade-type';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class UpgradeTypeService {

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + '/api/upgradetype';

  constructor(private http: HttpClient) { }

  index() {
    return this.http.get<UpgradeType[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('UpgradeTypeService.index(): Error retrieving list of all upgrade types');
      })
    );
  }

  show(id: number) {
    return this.http.get<UpgradeType>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('UpgradeTypeService.show(): Error retrieving single upgrade type instance');
      })
    );
  }
}
