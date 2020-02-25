import { Ship } from './ship';

export class Image {

  // FIELDS

  id: number;
  photoUrl: string;

  // RELATIONSHIPS

  ships: Ship[];

  // CONSTRUCTOR

  constructor(id?: number, photoUrl?: string, ships?: Ship[]) {
    this.id = id;
    this.photoUrl = photoUrl;
    this.ships = ships;
  }
}
