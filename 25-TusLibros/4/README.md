# Tus Libros

## Servidor

En la carpeta `api` se encuentra el archivo `TusLibros.st` con el servidor en Smalltalk. Para crear el servidor abrir un workspace y ejecutar:

```smalltalk
TusLibrosController listeningOn: 8082.
```

El servidor se queda escuchando en el puerto `8082` (se puede verificar desde el browser ingresando la url `http://localhost:8082/helloWorld`)
En caso de querer detener el servidor, encontramos útil frenar todas las instancias posiblemente activas:

```smalltalk
TusLibrosController allInstancesDo: [:e | e stopListening; destroy].
```

Los servicios que brinda el servidor:
- `helloWorld`
- `getCatalog`
- `createCart?userID=${userID}&password=${password}`
- `addToCart?cartID=${cartID}&isbn=${isbn}&quantity=${quantity}`
- `removeFromCart?cartID=${cartID}&isbn=${isbn}`
- `listCart?cartID=${cartID}`
- `checkoutCart?cartID=${cartID}`
- `listPurchases?userID=${userID}&password=${password}`

### Usuarios
El servidor se inicializa con dos usuarios:
1. `userID: Eden` -- `password: 12345678`
2. `userID: Santi` -- `password: 12345678`

Ninguno tiene compras ni carritos aún.

### Libros
El servidor también viene inicializado con un cátalogo con 5 libros. Se pueden ver usando el endpoint
de `getCatalog` (y es lo que va a usar el cliente)

## Cliente
Nosotros decidimos usar siempre el script `./server.sh` para levantar el cliente, 
de manera que recomendamos usar lo mismo.
El cliente se accede desde `http://localhost:8081`

#### Requisitos
- Python3
- El paquete [`websockets`](https://websockets.readthedocs.io/en/stable/intro.html)

#### Compilación
Todo fue desarrollado usando `./cliente.sh`, de manera que `index.html` ya deberia estar compilado.
