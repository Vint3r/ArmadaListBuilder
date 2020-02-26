import { TestBed } from '@angular/core/testing';

import { ListBuildService } from './list-build.service';

describe('ListBuildService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: ListBuildService = TestBed.get(ListBuildService);
    expect(service).toBeTruthy();
  });
});
