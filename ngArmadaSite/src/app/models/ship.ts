import { HullZone } from './hull-zone';
import { Speed } from './speed';
import { ShipUpgradeType } from './ship-upgrade-type';
import { ShipDefenseToken } from './ship-defense-token';
import { Image } from './image';

export class Ship {
  // FIELDS

  id: number;
  afRed: number;
  afBlue: number;
  afBlack: number;
  command: number;
  cost: number;
  engineering: number;
  hull: number;
  squadron: number;
  alignment: string;
  baseSize: string;
  name: string;

  // RELATIONSHIPS

  hullZones: HullZone[];
  speed: Speed;
  defenseTokens: ShipDefenseToken[];
  images: Image[];
  upgradeTypes: ShipUpgradeType[];

  // CONSTRUCTOR

  constructor(id?: number,
              afRed?: number,
              afBlue?: number,
              afBlack?: number,
              command?: number,
              cost?: number,
              engineering?: number,
              hull?: number,
              squadron?: number,
              alignment?: string,
              baseSize?: string,
              name?: string,
              hullZones?: HullZone[],
              defenseTokens?: ShipDefenseToken[],
              images?: Image[],
              upgradeTypes?: ShipUpgradeType[],
              speed?: Speed) {
    this.id = id;
    this.afRed = afRed;
    this.afBlue = afBlue;
    this.afBlack = afBlack;
    this.command = command;
    this.cost = cost;
    this.engineering = engineering;
    this.hull = hull;
    this.squadron = squadron;
    this.alignment = alignment;
    this.baseSize = baseSize;
    this.name = name;
    this.hullZones = hullZones;
    this.defenseTokens = defenseTokens;
    this.images = images;
    this.upgradeTypes = upgradeTypes;
    this.speed = speed;
  }
}
