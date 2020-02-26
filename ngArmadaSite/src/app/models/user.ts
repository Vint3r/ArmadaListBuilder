import { ListBuild } from './list-build';

export class User {

  // FIELDS

  id: number;
  username: string;
  password: string;

  // RELATIONSHIPS

  lists: ListBuild[];

  // CONSTRUCTOR

  constructor(id?: number, username?: string, password?: string, lists?: ListBuild[]) {
    this.id = id;
    this.username = username;
    this.password = password;
    this.lists = lists;
  }
}
