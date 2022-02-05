
# backend_rd

<br/>
<h2>Ejercicio</h2>
<br/>

<h2>------Detalles técnicos------</h2>
<br/>
<p>Se creó un diseño de base de datos tomando en cuenta la modificación del JSON de input para poder contar con un mejor performance en cuanto a la integridad de la información, el core principal se bajó a nivel de BD dejando en un SP gran parte del cálculo, devolviendo un JSON nutrido con información apropiada para la correcta visualización de lo que sucedió en el proceso del cálculo, se añade el diseño de la base de datos, el diseño cumple con los requisitos mínimos y el plus que pide el desarrollo el cual es calcular el pago de los jugadores de más de un equipo, el diseño soporta la creación de varios equipos de futbol y cuenta con un catálogo de tipos de jugadores, teniendo así mismo una tabla que engloba ambos datos, con esto se garantiza que podemos configurar diferentes niveles de jugadores dependiendo del equipo, al hacerlo un dato único a nivel de tabla podemos únicamente configurar un único nivel por equipo por lo que no habrán configuraciones de niveles repetidos en los equipos, una vez configurada esta parte se le asigna al jugador para tener un dato que engloba tanto al equipo, al nivel y la cantidad de goles que se esperan por mes, podemos tener N cantidad de equipos con diferentes configuración de niveles.

<p>Desde java se envía de forma transparente el JSON no sin antes hacerle una revisión de que cumple requisitos de INPUT, el SP también hace verificaciones de integridad de formato y de datos, nos devuelve un JSON lleno y en java procesamos para el cálculo final que es el porcentaje por equipo, para finalmente enviar el JSON. </p>


<p>El diseño del servicio está compuesto por 4 paquetes:
Controlador: se encarga de la recepción de la información del frontend
Payload: configuración del json de entrada
Modelo: Procesamiento de los datos a nivel de BD y cálculos adicionales
Utilerías: Compuesto por una clase con métodos usados a lo largo del proyecto</p>

<br/>
<h2>Implementación y pruebas</h2>

<p>->Es necesario contar con el servidor de base de datos (MySQL)MariaDB 10.4.13 </p>
<p>->Se deja en raiz el war para despliegue llamado rd.war</p>
<p>->Se uso como servidor de aplicaciones: GlassFish Server 4.1.1</p>
<p>->Como IDE se uso Netbeans 8.2 RC</p>
<p>->El Servidor de aplicaciones corre en el puerto: 10593, favor de modificarlo si en el local de testing es diferente.</p>

<p>En raíz viene un archivo llamado -index.html-, desde el cual se puede testear mas cómodamente el desarrollo, ya que usa una pequeña interfaz, asi mismo se deja un archivo llamado -llamadas de prueba apirest json.bash- en el cual vienen diferentes pruebas hechas a lo largo del desarrollo y con diferentes fines, se deja por aparte el SP para testeo independiente en el archivo Script_sp.sql, dejo de cualquier manera algunas opciones de testing aquí:</p>

<p>curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"1\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"6\",  \"goles\":\"11\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"8\",  \"goles\":\"3\",  \"sueldo_completo\":\"15\"},{ \"id_jugador\":\"10\",  \"goles\":\"4\",  \"sueldo_completo\":\"0\"}] }" http://localhost:10593/rd/Calculo_pago_jugadores.do<p>
  
<p>curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"7\",  \"goles\":\"10\",  \"sueldo_completo\":\"15\"},{ \"id_jugador\":\"9\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"10\",  \"goles\":\"5\",  \"sueldo_completo\":\"0\"}] }" http://localhost:10593/rd/Calculo_pago_jugadores.do<p>
  
  
