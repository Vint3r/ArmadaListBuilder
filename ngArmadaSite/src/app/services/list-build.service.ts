import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { ListBuild } from '../models/list-build';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ListBuildService {

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + '/api/listbuild';

  constructor(private http: HttpClient) { }

  index() {
    return this.http.get<ListBuild[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ListBuildService.index(): Error retrieving list of all lists');
      })
    );
  }

  show(id: number) {
    return this.http.get<ListBuild>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ListBuildService.show(): Error retrieving single list');
      })
    );
  }

  updateListBuild(list: ListBuild) {
    const httpOptions = {
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-type': 'application/json'
      }
    };

    return this.http.put(this.url + '/update/' + list.id, list, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ListBuildService.updateListBuild(): Error updating list');
      })
    );
  }

  createListBuild(newList: ListBuild) {
    const httpOptions = {
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-type': 'application/json'
      }
    };

    return this.http.post(this.url + '/create', newList, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ListBuildService.createListBuild(): Error creating list');
      })
    );
  }

  deleteListBuild(delList: ListBuild) {
    return this.http.delete(this.url + '/delete/' + delList.id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ListBuildService.deleteListBuild(): Error deleting list instance.');
      })
    );
  }
}
