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
public class Calculol_sueldo_BO {
    
    private String nombre;
    private int goles;
    private int goles_minimos;
    private String sueldo;
    private float bono;
    private float sueldo_completo;
    private String calculo_individual;
    private String equipo;

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

    /**
     * @return the goles
     */
    public int getGoles() {
        return goles;
    }

    /**
     * @param goles the goles to set
     */
    public void setGoles(int goles) {
        this.goles = goles;
    }

    /**
     * @return the goles_minimos
     */
    public int getGoles_minimos() {
        return goles_minimos;
    }

    /**
     * @param goles_minimos the goles_minimos to set
     */
    public void setGoles_minimos(int goles_minimos) {
        this.goles_minimos = goles_minimos;
    }

    /**
     * @return the sueldo
     */
    public String getSueldo() {
        return sueldo;
    }

    /**
     * @param sueldo the sueldo to set
     */
    public void setSueldo(String sueldo) {
        this.sueldo = sueldo;
    }

    /**
     * @return the bono
     */
    public float getBono() {
        return bono;
    }

    /**
     * @param bono the bono to set
     */
    public void setBono(float bono) {
        this.bono = bono;
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

    /**
     * @return the calculo_individual
     */
    public String getCalculo_individual() {
        return calculo_individual;
    }

    /**
     * @param calculo_individual the calculo_individual to set
     */
    public void setCalculo_individual(String calculo_individual) {
        this.calculo_individual = calculo_individual;
    }

    /**
     * @return the equipo
     */
    public String getEquipo() {
        return equipo;
    }

    /**
     * @param equipo the equipo to set
     */
    public void setEquipo(String equipo) {
        this.equipo = equipo;
    }
    
}
