import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListaVuelosComponent } from './lista-vuelos.component';

describe('ListaVuelosComponent', () => {
  let component: ListaVuelosComponent;
  let fixture: ComponentFixture<ListaVuelosComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [ListaVuelosComponent]
    });
    fixture = TestBed.createComponent(ListaVuelosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
