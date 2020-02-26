import { ShipBuild } from './ship-build';
import { Image } from './image';
import { UpgradeType } from './upgrade-type';

export class Upgrade {

  // FIELDS

  id: number;
  name: string;
  unique: boolean;
  alignment: string;
  description: string;
  shipType: string;
  cost: number;

  // RELATIONSHIPS

  shipBuilds: ShipBuild[];
  image: Image;
  type: UpgradeType;

  // CONSTRUCTOR

  constructor(id?: number,
              name?: string,
              unique?: boolean,
              alignment?: string,
              description?: string,
              shipType?: string,
              cost?: number,
              shipBuilds?: ShipBuild[],
              image?: Image,
              type?: UpgradeType) {

    }
}
