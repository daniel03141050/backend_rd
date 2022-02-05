/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.controller.payload;

/**
 *
 * @author danie
 */
public class Jugadores_payload {
        
    public Jugadores_payload()
    {
        id_jugador="ND";
        goles="ND";
        sueldo_completo=0;
    }

    private String id_jugador;
    private String goles;
    private float sueldo_completo;

    /**
     * @return the id_jugador
     */
    public String getId_jugador() {
        return id_jugador;
    }

    /**
     * @param id_jugador the id_jugador to set
     */
    public void setId_jugador(String id_jugador) {
        this.id_jugador = id_jugador;
    }

    /**
     * @return the goles
     */
    public String getGoles() {
        return goles;
    }

    /**
     * @param goles the goles to set
     */
    public void setGoles(String goles) {
        this.goles = goles;
    }

    /**
     * @return the sueldo_completo
     */
    public float getSueldo_completo() {
        return sueldo_completo;
    }

    /**
     * @param sueldo_completo the sueldo_completo to set
     */
    public void setSueldo_completo(float sueldo_completo) {
        this.sueldo_completo = sueldo_completo;
    }

}