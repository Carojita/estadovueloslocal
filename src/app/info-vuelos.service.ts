import { Injectable } from '@angular/core';
import { HttpClient } from "@angular/common/http";
import { Vuelo } from './vuelo';

@Injectable({
  providedIn: 'root'
})
export class InfoVuelosService {
protected listaVuelos : Vuelo[] = [];
// Este método llama al API y obtiene el resultado.
private url = 'http://localhost/estadovuelos_api/api.php'
  constructor() {
   }
  public async getListaVuelos(origen: string, destino: string) :Promise<any[]>{
    let data = await fetch(this.url+"?origen="+origen+"&destino="+destino);
    return await data.json() ?? [];
   }
}
