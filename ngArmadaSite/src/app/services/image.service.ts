import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';
import { Image } from '../models/image';

@Injectable({
  providedIn: 'root'
})
export class ImageService {

  private baseUrl = environment.baseUrl;
  private url = this.baseUrl + '/api/image';

  constructor(private http: HttpClient) { }

  index() {
    return this.http.get<Image[]>(this.url).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ImageService.index(): Error retrieving list of all images');
      })
    );
  }

  show(id: number) {
    return this.http.get<Image>(this.url + '/' + id).pipe(
      catchError((err: any) => {
        console.error(err);
        return throwError('ImageService.show(): Error retrieving single image instance');
      })
    );
  }
}
