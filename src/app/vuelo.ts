export class Vuelo {
    id: string;
    destino: string;
    origen: string;
    aerolinea: string;
    estado: string;
    salida: string;
    llegada: string;
    demora: number;

    constructor(id: string, destino: string, origen: string, aerolinea: string, estado : string, salida: string, llegada: string, demora: number)
    {
        this.id = id;
        this.destino = destino;
        this.origen = origen;
        this. aerolinea = aerolinea;
        this.estado = estado;
        let options: Intl.DateTimeFormatOptions = { weekday: 'short', year: 'numeric', month: 'short', day: 'numeric', dayPeriod: 'narrow', hour: '2-digit', minute: '2-digit', timeZoneName:'short' };
        let formattedDate = new Intl.DateTimeFormat('es-US', options).format(new Date(salida));
        this.salida = formattedDate;
        formattedDate = new Intl.DateTimeFormat('es-US', options).format(new Date(llegada));
        this.llegada = formattedDate;
        this.demora = demora;
    }

}
