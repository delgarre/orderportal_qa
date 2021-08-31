/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.dao;

import com.learn.mycart.entities.Item;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

/**
 *
 * @author garre
 */
public class ItemDao {
    private SessionFactory factory;

    public ItemDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    
    public List<Item> pagination(){
    Session s = this.factory.openSession();
    Query query = s.createQuery("From Item");
    query.setFirstResult(0);
    query.setMaxResults(10);
    List<Item> list = list = query.list();
    return list;
}
    
    public List<Item> getItems(){
    Session s = this.factory.openSession();
    Query query = s.createQuery("From Item ORDER BY pDesc");
    
    List<Item> list = list = query.list();
    return list;
}
    
    public List<Item> getAllItemsByName(String name)
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Item as i where i.itemNumber =: name");
        query.setParameter("name", name);
        List<Item> list = query.list();
        return list;
    }
    
    public List<Item> getAllItemsBycId(int cid)
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Item as i where i.category.categoryId =: id");
        query.setParameter("id", cid);
        List<Item> list = query.list();
        return list;
    }
    
     public List<Item> getAllItemsById(int cid)
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Item as i where i.id =: is");
        query.setParameter("is", cid);
        List<Item> list = query.list();
        return list;
    }
    public List<Item> getAllItemsByIdandName(int cid, String name)
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Item as i where i.category.categoryId =: id and i.location.location =: name");
        query.setParameter("id", cid);
        query.setParameter("name", name);
        List<Item> list = query.list();
        return list;
    }
    
    public List<Item> getAllItemsByUOM(String uom)
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Item as i where i.unitOfMeasure =: uom");
        query.setParameter("uom", uom);
        List<Item> list = query.list();
        return list;
    }
    
    public boolean saveProduct(Item item){
        boolean f = false;
        try {
            
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();
            session.save(item);
            
            tx.commit();
            session.close();
            f = true;
            
        } catch (Exception e) {
            e.printStackTrace();
            f = false;
        }
        return f;
    }
        public List<Item> getActiveItems(){
    Session s = this.factory.openSession();
    Query query = s.createQuery("From Item where stat = 1 ORDER BY itemNumber");
    
    List<Item> list = list = query.list();
    return list;
}
        
          public List<Item> getDiscontinuedItems(){
    Session s = this.factory.openSession();
    Query query = s.createQuery("From Item where stat = 2 ORDER BY itemNumber");
    
    List<Item> list = list = query.list();
    return list;
}
          
          public Item getItemByItemNumber(String itemNumber){
        Item item = null;
        try {
            String query="from Item where itemNumber =: i";
            Session session = this.factory.openSession();
            Query q= session.createQuery(query);
            q.setParameter("i", itemNumber);
            item =(Item) q.uniqueResult();
        } catch (Exception e) {
           e.printStackTrace();
        }
        return item;
    }
}
