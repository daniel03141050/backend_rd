/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.model;

/**
 *
 * @author danie
 */
public class Jugadores_VO {
    
    private String id_jugador;
    private String nombre;

    /**
     * @return the id
     */
    public String getId_jugador() {
        return id_jugador;
    }

    /**
     * @param id the id to set
     */
    public void setId_jugador(String id) {
        this.id_jugador = id;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
