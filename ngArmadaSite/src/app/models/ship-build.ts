import { Ship } from './ship';

import { Upgrade } from './upgrade';
import { ListBuild } from './list-build';

export class ShipBuild {

  // FIELDS

  id: number;

  // RELATIONSHIPS

  ship: Ship;
  upgrades: Upgrade[];
  lists: ListBuild[];

  // CONSTRUCTOR

  constructor(id?: number, ship?: Ship, upgrades?: Upgrade[], lists?: ListBuild[]) {
    this.id = id;
    this.ship = ship;
    this.upgrades = upgrades;
    this.lists = lists;
  }
}
