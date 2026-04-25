import { TestBed } from '@angular/core/testing';

import { InfoVuelosService } from './info-vuelos.service';

describe('InfoVuelosService', () => {
  let service: InfoVuelosService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(InfoVuelosService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
