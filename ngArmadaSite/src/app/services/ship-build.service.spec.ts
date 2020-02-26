import { TestBed } from '@angular/core/testing';

import { ShipBuildService } from './ship-build.service';

describe('ShipBuildService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ShipBuildService = TestBed.get(ShipBuildService);
    expect(service).toBeTruthy();
  });
});
