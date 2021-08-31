/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.dao;

import com.learn.mycart.entities.SqlLog;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

/**
 *
 * @author garre
 */
public class SqlLogDao {
    
    private SessionFactory factory;

    public SqlLogDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    public List<SqlLog> getOrders(){
        Session s = this.factory.openSession();
        Query query = s.createQuery("from SqlLog");
        List<SqlLog> list = query.list();
        return list;
    }
    
}
