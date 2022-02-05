
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"1\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"6\",  \"goles\":\"11\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"8\",  \"goles\":\"3\",  \"sueldo_completo\":\"15\"},{ \"id_jugador\":\"10\",  \"goles\":\"4\",  \"sueldo_completo\":\"0\"}] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"


-- Prueba 2


						Goles minimos	Equipo		Goles anotados
5				Juan			5	Resuelve FC		6
6				Pedro			10	Resuelve FC		10
7				Martin			15	Resuelve FC		15
8				Luis			20	Resuelve FC		21
9				Juan Fake		3	La Competencia	4
10				Pedro Fake		5	La Competencia	6
11				Martin Fake		8	La Competencia	
12				Luis Fake		15	La Competencia	

--Ejercicio #1
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"6\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"6\",  \"goles\":\"10\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"7\",  \"goles\":\"15\",  \"sueldo_completo\":\"15\"},{ \"id_jugador\":\"8\",  \"goles\":\"20\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"9\",  \"goles\":\"4\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"10\",  \"goles\":\"6\",  \"sueldo_completo\":\"0\"}] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"



5	Juan	5	Resuelve FC	3
7	Martin	15	Resuelve FC	10
9	Juan Fake	3	La Competencia	3
10	Pedro Fake	5	La Competencia	5


--Ejercicio #2
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"7\",  \"goles\":\"10\",  \"sueldo_completo\":\"15\"},{ \"id_jugador\":\"9\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"10\",  \"goles\":\"5\",  \"sueldo_completo\":\"0\"}] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"

--Ejercicio #3
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"6\",  \"goles\":\"10\",  \"sueldo_completo\":\"15\"}] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"


5	Juan	5	Resuelve FC	3
7	Martin	15	Resuelve FC	10
9	Juan Fake	3	La Competencia	2
10	Pedro Fake	5	La Competencia	5
--Ejercicio #4
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"7\",  \"goles\":\"10\",  \"sueldo_completo\":\"15\"},{ \"id_jugador\":\"9\",  \"goles\":\"2\",  \"sueldo_completo\":\"0\"},{ \"id_jugador\":\"10\",  \"goles\":\"5\",  \"sueldo_completo\":\"0\"}] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"

5	Juan	5	Resuelve FC	3

--Ejercicio #4
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"}] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"


--Ejercicio #5
curl -X POST -H "Content-type: application/json" "http://localhost:10593/rd/Get_jugadores.do"



curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"1\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"}] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"

#--Testing con errores

#ejemplo 1, tipo de dato
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"d\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"}] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"

#ejemplo 2, formato JSON
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [{ \"id_jugador\":\"5\",  \"goles\":\"3\",  \"sueldo_completo\":\"0\"] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"

#ejemplo 3, Sin elementos
curl -X POST -H "Content-type: application/json" -d "{ \"Jugadores\": [] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"

#ejemplo 4, Error en nombre de elemento
curl -X POST -H "Content-type: application/json" -d "{ \"Jugdores\": [] }" "http://localhost:10593/rd/Calculo_pago_jugadores.do"

#ejemplo 5, Sin envio
curl -X POST -H "Content-type: application/json" -d "{}" "http://localhost:10593/rd/Calculo_pago_jugadores.do"
























