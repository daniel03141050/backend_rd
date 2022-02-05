/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.utilerias;

import com.google.gson.Gson;
import com.mx.rd.controller.payload.Jugadores_payload;
import com.mx.rd.controller.payload.Request_calculo_pago;
import com.mx.rd.model.Calculo_sueldo_VO;
import java.util.ArrayList;
import java.util.function.Predicate;

/**
 *
 * @author danie
 */
public class Utilerias {
    
    public ArrayList<Jugadores_payload> check_json(String JSONpayload)
    {
        Gson gson = new Gson();
        ArrayList<Jugadores_payload> obj2=null;
        try {
            
                Request_calculo_pago obj_cp=gson.fromJson(JSONpayload, Request_calculo_pago.class);
                
                String json = new Gson().toJson(obj2);
                obj2=obj_cp.getJugadores();
                if(obj2.size()>0)
                {
                    System.out.println(" JSON ----> "+json);
                    obj2.forEach((e) -> {                        
                        Integer.parseInt(e.getId_jugador()); 
                        Integer.parseInt(e.getGoles());
                        System.out.println(e.getId_jugador()+"***"+e.getGoles());
                    });
                }
                else{
                    System.out.println("Sin datos ....");
                    return null;
                }
            
        } catch(Exception ex) { 
            System.out.println("Existe error en formato y/o en datos (JSON) ....");
            return null;
        }
        
        return obj2;
    }
    
    public boolean check_json(Request_calculo_pago obj_cp)
    {
        try {            
            Gson gson = new Gson();        
            String json_body = gson.toJson(obj_cp.getJugadores());
            ArrayList<Jugadores_payload> obj2=obj_cp.getJugadores();
            
            obj2.forEach((e) -> {
                Integer.parseInt(e.getId_jugador()); 
                Integer.parseInt(e.getGoles());
            });
            
        } catch(Exception ex) { 
            System.out.println("Existe error en formato de JSON ....");
            return false;
        }
        
        return true;
    }
    
    
    public void añadir_calculo_equipo(ArrayList<Calculo_sueldo_VO> jugadorArray,String equipo,float porcentaje)
    {
        float total_sueldo=0;
        for(Calculo_sueldo_VO obj_ms : jugadorArray) {
            if(obj_ms.getEquipo().equals(equipo))
            {
                total_sueldo=porcentaje<=1 ? (porcentaje*(obj_ms.getBono()/2)) : (obj_ms.getBono()/2);
                obj_ms.setSueldo_completo(total_sueldo+obj_ms.getSueldo_completo());
            }
        }
    }
    
    public Predicate<Calculo_sueldo_VO> filtroEquipo(String categoria) {
        return (Calculo_sueldo_VO l) -> {
          return l.getEquipo().equals(categoria);
        };
    }
    
}
