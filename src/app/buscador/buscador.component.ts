import { ListaVuelosComponent } from "./../lista-vuelos/lista-vuelos.component";
import { Component, inject, Inject } from "@angular/core";
import { CommonModule } from "@angular/common";
import { Vuelo } from "../vuelo";
import SampleResponse from "./data.json";
import { FormsModule } from "@angular/forms";
import { InfoVuelosService } from "../info-vuelos.service";

@Component({
  selector: "app-buscador",
  standalone: true,
  imports: [CommonModule, ListaVuelosComponent, FormsModule],
  templateUrl: "./buscador.component.html",
  styleUrls: ["./buscador.component.css"],
})
export class BuscadorComponent {
  listo : boolean = false;
  infoVuelosService : InfoVuelosService = inject(InfoVuelosService);
  aeroOrigen: string = "";
  aeroDestino: string = "";

  public listaVuelos: Vuelo[] = [];
  public traduceEstados(estado: string): string {
    if (estado == "scheduled") return "Programado";
    if (estado == "active") return "Activo";
    if (estado == "landed") return "Aterrizaje Completo";
    if (estado == "cancelled") return "Cancelado";
    if (estado == "incident") return "Incidente Reportado";
    if (estado == "diverted") return "Desviado";
    return "N/A";
  }
// Este método revisa que se haya ingresado el origen y el destino del vuelo, y se asegura de que no se use el mismo 
// aeropuerto para ambos. Actualmente no se usa esta validación como un requisito para realizar la consulta.
onSelectionChange(event: any) {
    this.listo = !(this.aeroDestino == this.aeroOrigen && this.aeroDestino != "" && this.aeroOrigen != "");
    return this.listo;
}
// Este método soluciona un aspecto de la respuesta del API al retornar null para los vuelos sin demora y un número 
// para los que están demorados, se unifica a números para respetar el valor creado en la clase Vuelo
  public enDemora(value: any): number {
    if (value == null) return 0;
    return value;
  }
// Este método llama los vuelos del api https://api.aviationstack.com/v1. El resultado incluye paginación, por lo
// que es necesario acceder al array data donde se encuentra la información del vuelo. Opté por no crear una 
// interfaz para mapear el resultado completo porque traía demasiada información, en lugar de eso, aquí se mapean
// los datos relevantes para el proyecto.
  async obtenerVuelos(): Promise<void>{
    let data: any = await this.infoVuelosService.getListaVuelos(this.aeroOrigen, this.aeroDestino);
    let datos = data;
    console.log(datos);
    let vuelos: Vuelo[] = [];
    for (let i: number = 0; i < datos.length; i++) {
      let id: string = datos[i].iata;
      let destino: string = datos[i].destino;
      let origen: string = datos[i].origen;
      let aerolinea: string = datos[i].aerolinea;
      let estado: string = datos[i].estado;
      let salida: string = datos[i].salida;
      let llegada: string = datos[i].llegada;
      let demora: number = this.enDemora(datos[i].demora);

      let nuevoVuelo = new Vuelo(
        id,
        destino,
        origen,
        aerolinea,
        estado,
        salida,
        llegada,
        demora,
      );
      vuelos.push(nuevoVuelo);
    }
    this.listaVuelos = vuelos;
  }
// Este metodo carga información extraída de una respuesta del API convertida en JSON. Debido a que el número de consultas 
// mensuales está limitado para las cuentas gratuitas que usan el API, usé este JSON para las primeras pruebas de los componentes 
// sin consumir los llamados limitados al API
  ngOnInit() {
    /*
    let data: any[] = SampleResponse.data;
    let vuelos: Vuelo[] = [];
    for (let i: number = 0; i < data.length; i++) {
      let id: string = data[i].flight.iata;
      let destino: string = data[i].arrival.iata;
      let origen: string = data[i].departure.iata;
      let aerolinea: string = data[i].airline.name;
      let estado: string = this.traduceEstados(data[i].flight_status);
      let salida: string = data[i].departure.estimated;
      let llegada: string = data[i].arrival.scheduled;
      let demora: number = this.enDemora(data[i].departure.delay);

      let nuevoVuelo = new Vuelo(
        id,
        destino,
        origen,
        aerolinea,
        estado,
        salida,
        llegada,
        demora,
      );
      vuelos.push(nuevoVuelo);
    }
    this.listaVuelos = vuelos;*/
  }
}
