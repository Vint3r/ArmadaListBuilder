import { FighterDefenseToken } from './fighter-defense-token';
import { Keyword } from './keyword';
import { ListFighter } from './list-fighter';
import { Image } from './image';

export class Fighter {

  // FIELDS

  id: number;
  name: string;
  unique: boolean;
  health: number;
  movement: number;
  cost: number;
  specialAbility: string;
  alignment: string;
  model: string;
  rating: number;
  afRed: number;
  afBlue: number;
  afBlack: number;
  asRed: number;
  asBlue: number;
  asBlack: number;

  // RELATIONSHIPS

  keywords: Keyword[];
  lists: ListFighter[];
  image: Image;
  defenseTokens: FighterDefenseToken[];

  // CONSTRUCTOR

  constructor(id?: number,
              name?: string,
              unique?: boolean,
              health?: number,
              movement?: number,
              cost?: number,
              specialAbility?: string,
              alignment?: string,
              model?: string,
              rating?: number,
              afRed?: number,
              afBlue?: number,
              afBlack?: number,
              asRed?: number,
              asBlue?: number,
              asBlack?: number,
              keywords?: Keyword[],
              lists?: ListFighter[],
              defenseTokens?: FighterDefenseToken[],
              image?: Image) {
                this.id = id;
                this.name = name;
                this.unique = unique;
                this.health = health;
                this.movement = movement;
                this.cost = cost;
                this.specialAbility = specialAbility;
                this.alignment = alignment;
                this.model = model;
                this.rating = rating;
                this.afRed = afRed;
                this.afBlue = afBlue;
                this.afBlack = afBlack;
                this.asRed = asRed;
                this.asBlue = asBlue;
                this.asBlack = asBlack;
                this.keywords = keywords;
                this.lists = lists;
                this.defenseTokens = defenseTokens;
                this.image = image;
    }

}
