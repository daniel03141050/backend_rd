/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.controller.payload;
import java.util.ArrayList;


/**
 *
 * @author danie
 */
public class Request_calculo_pago{
    
    public Request_calculo_pago()
    {
        
    }
    
    public ArrayList<Jugadores_payload> Jugadores;

    /**
     * @return the Jugadores_payload
     */
    public ArrayList<Jugadores_payload> getJugadores() {
        return Jugadores;
    }

    /**
     * @param Jugadores the Jugadores_payload to set
     */
    public void setJugadores(ArrayList<Jugadores_payload> Jugadores) {
        this.Jugadores = Jugadores;
    }
    
    
}
