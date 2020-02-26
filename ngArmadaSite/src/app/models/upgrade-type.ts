import { ShipUpgradeType } from './ship-upgrade-type';
import { Image } from './image';

export class UpgradeType {

  // FIELDS

  id: number;
  type: string;

  // RELATIONSHIPS

  image: Image;
  ships: ShipUpgradeType[];

  // CONSTRUCTOR

  constructor(id?: number, type?: string, image?: Image, ships?: ShipUpgradeType[]) {
    this.id = id;
    this.type = type;
    this.image = image;
    this.ships = ships;
  }
}
