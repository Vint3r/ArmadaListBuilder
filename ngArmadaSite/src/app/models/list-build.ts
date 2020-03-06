import { ListFighter } from './list-fighter';
import { ShipBuild } from './ship-build';
import { User } from './user';

export class ListBuild {

  // FIELDS

  id: number;
  name: string;
  desiredCost: number;
  actualCost: number;
  pointSway: number;
  pub: boolean;

  // RELATIONSHIPS

  fighters: ListFighter[];
  shipBuilds: ShipBuild[];
  users: User[];

  // CONSTRUCTOR

  constructor(id?: number,
              name?: string,
              desiredCost?: number,
              actualCost?: number,
              pointSway?: number,
              pub?: boolean,
              fighters?: ListFighter[],
              shipBuilds?: ShipBuild[],
              users?: User[]) {
    this.id = id;
    this.name = name;
    this.desiredCost = desiredCost;
    this.actualCost = actualCost;
    this.pointSway = pointSway;
    this.fighters = fighters;
    this.shipBuilds = shipBuilds;
    this.users = users;
    this.pub = pub;
  }
}
