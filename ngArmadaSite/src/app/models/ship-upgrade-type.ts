import { ShipUpgradeTypeId } from './ship-upgrade-type-id';
import { Ship } from './ship';
import { UpgradeType } from './upgrade-type';

export class ShipUpgradeType {

  // ID & FIELDS
  id: ShipUpgradeTypeId;
  amount: number;
  filled: boolean;

  // RELATIONSHIPS

  ship: Ship;
  upgradeType: UpgradeType;

  // CONSTRUCTOR

  constructor(id?: ShipUpgradeTypeId, amount?: number, filled?: boolean, ship?: Ship, upgradeType?: UpgradeType) {
    this.id = id;
    this.amount = amount;
    this.filled = filled;
    this.ship = ship;
    this.upgradeType = upgradeType;
  }
}
