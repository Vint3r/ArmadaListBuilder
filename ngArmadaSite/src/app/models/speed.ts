export class Speed {

  // FIELDS

  id: number;
  speedOne: string;
  speedTwo: string;
  speedThree: string;
  speedFour: string;

  // CONSTRUCTOR

  constructor(id?: number, speedOne?: string, speedTwo?: string, speedThree?: string, speedFour?: string) {
    this.id = id;
    this.speedOne = speedOne;
    this.speedTwo = speedTwo;
    this.speedThree = speedThree;
    this.speedFour = speedFour;
  }
}
