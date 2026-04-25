# estadovueloslocal
Implementación Angular y XAMPP de una aplicación para consultar el estado de los vuelos consultados de un API corriendo en localhost.

## Cómo usar
Esta impementación requiere tener XAMPP instalado. mueva la carpeta `estadovuelos_api` a su directorio de XAMPP en la carpeta `htdocs`. Ejecute el script de la base de datos `destadovuelos.sql`.  Ejecute el comando `npm install` en la carpeta `estadovueloslocal` seguido de `ng serve` para inicializar el front de **Angular** en localhost.

## Especificación del API

### GET

Retorna todos los vuelos o los vuelos con el destino y origen especificados en los parámetros `destino` y `origen` respectivamente. No retorna `404` si la consulta retorna vacía.

### POST

Crea un vuelo con la información provista en el **Body** de la petición con formato JSON. Ejemplo:
```json
{
    "iata":"LA004",
    "origen": "PEI",
    "destino": "CUC",
    "salida": "2026-04-30 15:00:00",
    "llegada": "2026-04-30 17:00:00",
    "aerolinea": "LA"
}
```
Retorna `500` si el código ``iata`` ya existe en la base de datos o si faltan atributos obligatorios (estado y demora son los únicos atributos opcionales.)

### PUT

Edita el vuelo identificado con el código ``iata`` usando la información provista en el **Body** de la petición con formato JSON. Ejemplo:
```json
{
    "iata":"LA004",
    "origen": "CLO"
}
```
Retorna `404` si el código ``iata`` no existe en la base de datos.

### DELETE

Edita el vuelo identificado con el código ``iata`` provisto en los parámetros de la petición.
Retorna `404` si el código ``iata`` no existe en la base de datos.