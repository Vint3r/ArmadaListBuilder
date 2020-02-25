import { ShipDefenseToken } from './ship-defense-token';
import { Image } from './image';
import { FighterDefenseToken } from './fighter-defense-token';

export class DefenseToken {

  // FIELDS

  id: number;
  name: string;
  effect: string;

  // RELATIONSHIPS

  ships: ShipDefenseToken[];
  fighters: FighterDefenseToken[];
  image: Image;

  // CONSTRUCTOR

  constructor(id?: number, name?: string, effect?: string, ships?: ShipDefenseToken[], fighters?: FighterDefenseToken[], image?: Image) {
    this.id = id;
    this.name = name;
    this.effect = effect;
    this.ships = ships;
    this.fighters = fighters;
    this.image = image;
  }
}
