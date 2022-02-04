/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.controller;

import com.google.gson.Gson;

import com.mx.rd.controller.payload.Jugadores_payload;

import com.mx.rd.controller.payload.Request_calculo_pago;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author danie
 */
public class Calculo_sueldo {
    private DataSource dataSource;
    private Request_calculo_pago obj_cp_response;
            
    String operacion(Request_calculo_pago obj_cp) 
    {
        
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
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
            
            
        }catch (SQLException e)
        {
            System.out.println("Error");
            System.out.println(e.getMessage());
        }
                
        return S;
            
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
