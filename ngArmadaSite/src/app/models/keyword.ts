import { Fighter } from './fighter';

export class Keyword {

  // FIELDS

  id: number;
  name: string;
  description: string;

  // RELATIONSHIPS

  fighters: Fighter[];

  // CONSTRUCTOR

  constructor(id?: number, name?: string, description?: string, fighters?: Fighter[]) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.fighters = fighters;
  }
}
