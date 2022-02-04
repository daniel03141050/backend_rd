/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.utilerias;

import com.mx.rd.model.Calculol_sueldo_BO;
import java.util.ArrayList;
import java.util.function.Predicate;

/**
 *
 * @author danie
 */
public class Utilerias {
    
    public void añadir_calculo_equipo(ArrayList<Calculol_sueldo_BO> jugadorArray,String equipo,float porcentaje)
    {
        float total_sueldo=0;
        for(Calculol_sueldo_BO obj_ms : jugadorArray) {
            if(obj_ms.getEquipo().equals(equipo))
            {
                total_sueldo=porcentaje<=1 ? (porcentaje*(obj_ms.getBono()/2)) : (obj_ms.getBono()/2);
                obj_ms.setSueldo_completo(total_sueldo+obj_ms.getSueldo_completo());
            }
        }
    }
    
    public static Predicate<Calculol_sueldo_BO> filtroEquipo(String categoria) {
        return (Calculol_sueldo_BO l) -> {
          return l.getEquipo().equals(categoria);
        };
    }
    
}
