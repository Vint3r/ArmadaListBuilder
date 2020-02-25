import { Ship } from './ship';

export class HullZone {

  // FIELDS

  id: number;
  shields: number;
  location: string;
  asRed: number;
  asBlue: number;
  asBlack: number;

  // RELATIONSHIPS

  ships: Ship[];

  // CONSTRUCTOR

  constructor(id?: number, shields?: number, location?: string, asRed?: number, asBlue?: number, asBlack?: number, ships?: Ship[]) {
    this.id = id;
    this.shields = shields;
    this.location = location;
    this.asRed = asRed;
    this.asBlue = asBlue;
    this.asBlack = asBlack;
    this.ships = ships;
  }
}
