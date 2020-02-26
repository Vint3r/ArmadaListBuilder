import { TestBed } from '@angular/core/testing';

import { UpgradeTypeService } from './upgrade-type.service';

describe('UpgradeTypeService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: UpgradeTypeService = TestBed.get(UpgradeTypeService);
    expect(service).toBeTruthy();
  });
});
