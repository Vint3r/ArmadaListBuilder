import { FighterDefenseTokenId } from './fighter-defense-token-id';
import { ShipDefenseTokenId } from './ship-defense-token-id';
import { Ship } from './ship';
import { DefenseToken } from './defense-token';

export class ShipDefenseToken {

  // ID & FIELDS

  id: ShipDefenseTokenId;
  amount: number;

  // RELATIONSHIPS

  ship: Ship;
  defenseToken: DefenseToken;

  // CONSTRUCTOR

  constructor(id?: ShipDefenseTokenId, amount?: number, ship?: Ship, defenseToken?: DefenseToken) {
    this.id = id;
    this.amount = amount;
    this.ship = ship;
    this.defenseToken = defenseToken;
  }
}
