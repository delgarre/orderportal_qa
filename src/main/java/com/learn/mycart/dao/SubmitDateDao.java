/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.dao;


import com.learn.mycart.entities.SubmitDate;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

/**
 *
 * @author garre
 */
public class SubmitDateDao {
    
        private SessionFactory factory;

    public SubmitDateDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public List<SubmitDate> getDate(){
        Session s= this.factory.openSession();
        Query query = s.createQuery("from SubmitDate where id =1");
        List<SubmitDate> list= query.list();
        return list;
    }
}
