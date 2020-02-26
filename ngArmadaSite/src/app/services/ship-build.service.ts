import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { ShipBuild } from '../models/ship-build';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ShipBuildService {

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + '/api/shipbuild';

  constructor(private http: HttpClient) { }

  index() {
    return this.http.get<ShipBuild[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ShipBuildService.index(): Error retrieving list of all ship builds');
      })
    );
  }

  show(id: number) {
    return this.http.get<ShipBuild>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ShipBuildService.show(): Error retrieving single ship build instance');
      })
    );
  }

  updateShipBuild(build: ShipBuild) {
    const httpOptions = {
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-type': 'application/json'
      }
    };

    return this.http.put(this.url + '/update/' + build.id, build, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ShipBuildService.updateShipBuild(): Error updating ship build');
      })
    );
  }

  createShipBuild(newBuild: ShipBuild) {
    const httpOptions = {
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Content-type': 'application/json'
      }
    };

    return this.http.post(this.url + '/create', newBuild, httpOptions).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ShipBuildService.createShipBuild(): Error creating ship build');
      })
    );
  }

  deleteShipBuild(delBuild: ShipBuild) {
    return this.http.delete(this.url + '/delete/' + delBuild.id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ShipBuildService.deleteShipBuild(): Error deleting ship build instance.');
      })
    );
  }
}
