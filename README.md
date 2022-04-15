<!-- Este es mi formato para escribir readmes-->

# SQL
## Conceptos

Una de las herramientas mas importantes para desarrollar aplicaciones web es el uso de *SQL*. En particular yo uso **MariaDB**, una base de datos relacional que permite almacenar datos en forma de tablas.
Tambien se pueden usar otras como:

* MySQL
    * Este es el gestor de bases de datos mas utilizado en la actualidad
* PostgreSQL
    * Este es el gestor de bases de datos mas profesional
* SQLite
    * Este es el gestor de bases de datos mas sencillo
[faztweb.com]: (https://faztweb.com/)

> Nota: Las bases de datos relacionales son una de las herramientas mas utilizadas en la actualidad.

---
En este codigo se muestra la declaración de una tabla en SQL:

```sql
DELIMITER //
CREATE FUNCTION CALCULO(precio DECIMAL)
  RETURNS DECIMAL
  BEGIN
    DECLARE IVA DECIMAL;
    SET IVA=precio*1.18;
    RETURN IVA;
  END //
  ```

  <!-- crear un tabla -->
  | Metas  | Descripcion     |
  |:------:|:---------------:|
  | PYTHON | Data Science    |
  | MARIADB| Data Engineering|
  | DJANGO | Web Development |

![Logo de marca EKKKO](espiral.jpg)


<!-- GITHUB MARKDOWN -->
* [ ] simbolo
* [x] simbolo

@faztweb 
:smiley: 
:trollface:



