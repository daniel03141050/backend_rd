/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author danie
 */
public class Jugadores_BO {
    private DataSource dataSource;
    
    public ArrayList<Jugadores_VO> Get_jugadores()
    {         
        ArrayList<Jugadores_VO> objarray=new ArrayList<>();
        String query = "SELECT id_jugador,nombre FROM jugador";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(getDataSource());
        List<Map<String,Object>> empRows = jdbcTemplate.queryForList(query);
        Jugadores_VO Jugadores2=null;
        for(Map<String,Object> empRow : empRows){
            Jugadores2=new Jugadores_VO();
            Jugadores2.setId_jugador( empRow.get("id_jugador")+"");
            Jugadores2.setNombre(empRow.get("nombre")+"");
            objarray.add(Jugadores2);
        }
        return objarray;
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
    
}
