# ***DOCUMENTACIÓN***

## **Indice** 📚
  - [Informacion](#informacion)
  - [Introduccion 📕](#introduccion)
  - [Normalizacion 🧑🏼‍💻](#normalizacion)
    - [Primera 🥇](#primeraN)
    - [Segunda 🥈](#segundaN)
    - [Tercera 🥉](#terceraN)
  - [Versiones 🔧](#versiones)

<div id='informacion'>

## **Informacion**

``` python
universidad = "Universidad San Carlos De Guatemala"
facultad = "Facultad De Ingenieria"
escuela = "Escuela De Ciencias Y Sistemas"
curso = "Sistemas De Bases De Datos 1"
nombre  = "Diego Andrés Obín Rosales"
carne = 201903865
```


<div id='introduccion'>

## **Introduccion** 📕
    
Con la finalidad de la implementacion de `Bases de Datos` así como, diseño del mismo se llevo a cabo el Segundo Proyecto del curso. Dicha implementacion permitió el acceso a `Consultas` a las `Tablas` de la `Base de Datos`.


<div id='normalizacion'>

## **Normalizacion** 🧑🏼‍💻

Como ejemplo de las reglas de `Normalizacion` aplicadas se ha tomado una pequeña porción de la tabla de entrada, tabla temporal o archivo de entrada:

![](https://github.com/DiiAns23/Prueba-2/blob/Master/normalizacion.PNG)

<div id='primeraN'>

- **Primera**

    En la _Primera Forma Normal_ se ha separado de la tabla original los registros correspondientes a `Zona`, `Eleccion`, `Sexo`, `Partido` y `Raza`

    ![](https://github.com/DiiAns23/Prueba-2/blob/Master/primera.PNG)

<div id='segundaN'>

- **Segunda**

    En la  _Segunda Forma Normal_ se han separado por `Claves` los registros `identificadores` de cada tabla, creando asi una reduccion en el tamaño de las tablas. Se realizó la separación de _Pais, Region, Departamento y Municipio_ para un mejor manejo de los datos.

    ![](https://github.com/DiiAns23/Prueba-2/blob/Master/segunda.PNG)

<div id='terceraN'>

 - **Tercera**

    En la _Tercera Forma Normal_ se han separado los `Resultados` correspondientes a cada registro. Se ha expandido la tabla `Eleccion` creando de ella las tablas `Tipo` y `Año` evitando de esta manera el incremento de los datos en la tabla `Eleccion`.

    ![](https://github.com/DiiAns23/Prueba-2/blob/Master/tercera.PNG)

<div id='versiones'>

## **Aplicaciones y Versiones Utilizadas**

![MySQL](https://img.shields.io/badge/-MySQL-0d0d0d?style=flat&logo=mysql) _Server version 8.0.26_

![Visual Studio Code](https://img.shields.io/badge/-Visual%20Studio%20Code-0d0d0d?style=flat&logo=visual-studio-code&logoColor=007ACC) _Visual Studio Code Version 1.61.2_

