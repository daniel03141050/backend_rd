/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.controller;

import com.mx.rd.model.Calculo_sueldo_BO;
import com.mx.rd.model.Jugadores_BO;
import com.mx.rd.model.Jugadores_VO;
import java.util.ArrayList;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
/**
 *
 * @author danie
 */
@RestController
public class Controller_jugadores {
    
    @CrossOrigin(origins = "*")
    @PostMapping("/Calculo_pago_jugadores.do")
    public String calculo_sueldo(@RequestBody String List_jugadores) {
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Calculo_sueldo_BO obj_cs = (Calculo_sueldo_BO) ctx.getBean("Calculo_sueldo_BO");
        
        return obj_cs.operacion(List_jugadores);
        
    }
    
    @CrossOrigin(origins = "*")
    @PostMapping("/Get_jugadores.do")
    public  ArrayList<Jugadores_VO> get_jugadores() {
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Jugadores_BO obj_cs = (Jugadores_BO) ctx.getBean("Jugadores_BO");
        
        return obj_cs.Get_jugadores();
        
    }
    
}
