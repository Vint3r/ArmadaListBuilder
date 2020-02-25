import { ListFighterId } from './list-fighter-id';
import { Fighter } from './fighter';
import { ListBuild } from './list-build';

export class ListFighter {

  // ID & FIELDS

  id: ListFighterId;
  amount: number;

  // RELATIONSHIPS

  fighter: Fighter;
  list: ListBuild;

  // CONSTRUCTOR

  constructor(id: ListFighterId, amount?: number, fighter?: Fighter, list?: ListBuild) {
    this.id = id;
    this.amount = amount;
    this.fighter = fighter;
    this.list = list;
  }
}
