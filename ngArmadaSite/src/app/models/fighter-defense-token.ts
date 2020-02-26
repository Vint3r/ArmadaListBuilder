import { FighterDefenseTokenId } from './fighter-defense-token-id';
import { DefenseToken } from './defense-token';
import { Fighter } from './fighter';

export class FighterDefenseToken {

  // ID & FIELDS

  id: FighterDefenseTokenId;
  amount: number;

  // RELATIONSHIPS

  fighter: Fighter;
  defenseToken: DefenseToken;

  // CONSTRUCTOR

  constructor(id?: FighterDefenseTokenId, amount?: number, fighter?: Fighter, defenseToken?: DefenseToken) {
    this.id = id;
    this.amount = amount;
    this.fighter = fighter;
    this.defenseToken = defenseToken;
  }
}
