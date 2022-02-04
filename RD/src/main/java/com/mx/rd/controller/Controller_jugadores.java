/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mx.rd.controller;

import com.mx.rd.model.Calculo_sueldo_VO;
import com.mx.rd.controller.payload.Request_calculo_pago;
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
    public String calculo_sueldo(@RequestBody Request_calculo_pago List_jugadores) {
        
        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext("spring.xml");
        Calculo_sueldo_VO obj_cs = (Calculo_sueldo_VO) ctx.getBean("Controller_sueldo");
        
        return obj_cs.operacion(List_jugadores);
        
    }
    
        
    
}
