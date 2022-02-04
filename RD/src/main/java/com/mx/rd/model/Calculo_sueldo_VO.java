/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.model;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import com.mx.rd.controller.payload.Jugadores_payload;

import com.mx.rd.controller.payload.Request_calculo_pago;
import com.mx.rd.utilerias.Utilerias;

import java.lang.reflect.Type;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Collectors;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author danie
 */
public class Calculo_sueldo_VO {
    private DataSource dataSource;
    private Request_calculo_pago obj_cp_response;
    private ArrayList<Calculol_sueldo_BO> jugadorArray;
    private Utilerias obj_utilerias;
    public String operacion(Request_calculo_pago obj_cp) 
    {
        obj_utilerias=new Utilerias();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
        Gson gson = new Gson();
        String S=null;
        try
        {
            
            ArrayList<Jugadores_payload> obj2=obj_cp.getJugadores();
            String json = new Gson().toJson(obj2);
            System.out.println(" JSON ----> "+json);
            
            Connection connection = jdbcTemplate.getDataSource().getConnection();
            CallableStatement callableStatement = connection.prepareCall("{CALL calculo_equipo_json(?,?)}");
            callableStatement.setString(1, json);
            callableStatement.registerOutParameter(2, Types.VARCHAR);
            callableStatement.executeUpdate();
            
            S = callableStatement.getString(2);
            
            System.out.println("------>"+S);
            
            Type userListType = new TypeToken<ArrayList<Calculol_sueldo_BO>>(){}.getType();
            
            jugadorArray = gson.fromJson(S, userListType);
            
            /*
                obtener el porcentaje de los equipos
            */
            Map<String, Long> equipos = jugadorArray.stream().collect(Collectors.groupingBy(Calculol_sueldo_BO::getEquipo, Collectors.counting()));
            
            equipos.keySet().forEach((obj_ms) -> {
                float goles_reales=jugadorArray.stream().filter(obj_utilerias.filtroEquipo(obj_ms)).mapToInt(C -> C.getGoles()).sum();                
                float goles_minimos=jugadorArray.stream().filter(obj_utilerias.filtroEquipo(obj_ms)).mapToInt(C -> C.getGoles_minimos()).sum();
                float porcentaje_equipo=goles_reales/goles_minimos;
                obj_utilerias.añadir_calculo_equipo(jugadorArray,obj_ms,porcentaje_equipo);
            });
            
            for(Calculol_sueldo_BO obj_ms : jugadorArray) {
                System.out.println("Nombre = "+obj_ms.getNombre()+" Goles minimos "+obj_ms.getGoles_minimos()+" Goles reales "+obj_ms.getGoles()+" Calculo Pago "+obj_ms.getSueldo_completo());
            }
            
        }catch (SQLException e)
        {
            System.out.println("Error");
            System.out.println(e.getMessage());
        }
        String json = new Gson().toJson(jugadorArray);
        JsonElement jsonElement = new JsonParser().parse(json);
        
        JsonObject jsono=new JsonObject();        
        jsono.add("Jugadores", jsonElement);
        
        return jsono.toString();
    }
    
    
    
    /**
     * @return the dataSource
     */
    public DataSource getDataSource() {
        return dataSource;
    }

    /**
     * @param dataSource the dataSource to set
     */
    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    /**
     * @return the obj_cp_response
     */
    public Request_calculo_pago getObj_cp_response() {
        return obj_cp_response;
    }

    /**
     * @param obj_cp_response the obj_cp_response to set
     */
    public void setObj_cp_response(Request_calculo_pago obj_cp_response) {
        this.obj_cp_response = obj_cp_response;
    }

    
}
