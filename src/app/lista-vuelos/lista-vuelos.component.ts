import { Vuelo } from './../vuelo';
import { Component, Input } from '@angular/core';

@Component({
  selector: "[app-lista-vuelos]",
  standalone: true,
  templateUrl: './lista-vuelos.component.html',
  styleUrls: ['./lista-vuelos.component.css']
})
export class ListaVuelosComponent {
  @Input() vuelo!: Vuelo;
}
