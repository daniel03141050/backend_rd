
#Test exitoso
SET @folio='';
CALL calculo_equipo_json('[{ "id_jugador":"5",  "goles":"1",  "sueldo_completo":"5"},{ "id_jugador":"6",  "goles":"11",  "sueldo_completo":"500"},{ "id_jugador":"8",  "goles":"3",  "sueldo_completo":"15"}]',@folio);
SELECT @folio;

#Test con error,, un jugador no existe en BD, se devuelve NULL
SET @folio='';
CALL calculo_equipo_json('[{ "id_jugador":"5",  "goles":"1",  "sueldo_completo":"5"},{ "id_jugador":"6",  "goles":"11",  "sueldo_completo":"500"},{ "id_jugador":"1",  "goles":"3",  "sueldo_completo":"15"}]',@folio);
SELECT @folio;


DROP PROCEDURE IF EXISTS `calculo_equipo_json`;
DELIMITER $$
CREATE OR REPLACE PROCEDURE `calculo_equipo_json` (
	IN pParametroJson    JSON,
	OUT pParametroJsonOut JSON
)
BEGIN 
    DECLARE vJsonEsValido INT;
    DECLARE vItems INT;
    DECLARE vIndex BIGINT UNSIGNED DEFAULT 0;
    
    # Variables para parseo del objeto JSON
    DECLARE vCampo1 VARCHAR(100);
    DECLARE vCampo2 VARCHAR(100);
    DECLARE vCampo3 VARCHAR(100);
	
	#
	DECLARE fnombre VARCHAR(100);
	DECLARE fgolesmensuales VARCHAR(100);
	DECLARE fsueldo DECIMAL(12,2);
	DECLARE fsueldo_completo DECIMAL(12,2);
	DECLARE fbono VARCHAR(100);
	DECLARE fcalculobonoindividual DECIMAL(12,2);
	DECLARE fnombreequipo VARCHAR(100);
    	
	DECLARE json_out JSON;
	DECLARE json_out2 JSON;
	
	SET json_out = '[]';
	SET json_out2 = '[]';
	SET pParametroJsonOut='[]';
	#--SET json_out2 = '{}';
    SET vJsonEsValido = JSON_VALID(pParametroJson);
    
    IF vJsonEsValido = 0 THEN 
        # El objeto JSON no es válido, salimos prematuramente
        #--SELECT "JSON suministrado no es válido";
		SELECT '[]' INTO pParametroJsonOut;
    ELSE 
	
        # Nuestro objeto es válido, podemos proceder
        SET vItems = JSON_LENGTH(pParametroJson);
        
        # El objeto es válido y contiene al menos un elemento
        IF vItems > 0 THEN 
            
            WHILE vIndex < vItems DO
			
                SET vCampo1 = JSON_UNQUOTE(JSON_EXTRACT(pParametroJson, CONCAT('$[', vIndex, '].id_jugador')));
                SET vCampo2 = JSON_UNQUOTE(JSON_EXTRACT(pParametroJson, CONCAT('$[', vIndex, '].goles')));
                SET vCampo3 = JSON_EXTRACT(pParametroJson, CONCAT('$[', vIndex, '].sueldo_completo'));
				SET fnombre=null;
				
				SELECT 	j.nombre,den.goles_mensuales,j.sueldo,j.bono,if( ( vCampo2 /den.goles_mensuales)*(j.bono/2) <= (j.bono/2) , ( vCampo2 /den.goles_mensuales)*(j.bono/2) , (j.bono/2) ),e.nombre INTO fnombre,fgolesmensuales,fsueldo,fbono,fcalculobonoindividual,fnombreequipo FROM Jugador j INNER JOIN detalle_equipo_nivel den ON den.id_den=j.id_den AND id_jugador=vCampo1 INNER JOIN equipo e ON den.id_equipo=e.id_equipo;
				
				SET fsueldo_completo=fsueldo+fcalculobonoindividual;
                				
				SELECT JSON_OBJECT( 'nombre',fnombre,'goles_minimos',fgolesmensuales,'goles',vCampo2,'sueldo',fsueldo,'bono',fbono,'sueldo_completo',fsueldo_completo,'calculo_individual',fcalculobonoindividual,'equipo', fnombreequipo ) INTO json_out;
								
				SELECT JSON_INSERT(pParametroJsonOut, CONCAT('$[', vIndex, ']'),  json_out) INTO pParametroJsonOut;
				
				SET vIndex = vIndex + 1;
				
				#--Verificación de existencia de jugadores
				IF fnombre IS NULL THEN
					SET vIndex = vItems;
					SET pParametroJsonOut='[]';
				END IF;
				
            END WHILE;
            
        END IF;
		
		SELECT REPLACE(REPLACE(REPLACE(JSON_EXTRACT(pParametroJsonOut, '$[*]'), '"{', "{"), '}"', "}"), "\\", "") INTO pParametroJsonOut;
				
    END IF;
END




