
# Prueba Back Reddan

Para inicializar el proyecto debemos tener instalado NodeJs en nuestro equipo.



## Pasos para inicializar el proyecto

Clonar el proyecto

```bash
  git clone https://github.com/wilcoxmarin/prueba-reddan-backend.git
```
Este paso es opcional para levantar una base de datos se utilizo docker si tu trabajas con LAMP no es necesario hacer este paso, en el caso contrio ejecutas el sieguiente comando.

```bash
  cd prueba-reddan-backend && docker-compose up -d
```

En este paso procederemos a correr el backend, pero debemos instalar primero las dependencias, debemos que estar dentro del proyecto para ejecutar el siguiente comando.
```bash
  npm install
```

Correr el proyecto

```bash
  npm run dev
```


## Configuracion

Para configurar las cedenciasles de la conexión a la base de datos debemos ir a  project/config/db.ts y ahi modificamos nuestras credenciales de la base de datos que son :

    *user
    *password
    *database
    *port
    *host

Tambien en la parte de scripts esta el sql para crear la base de datos y cargar información.
