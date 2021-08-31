/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.learn.mycart.entities;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author garre
 */
@Entity
public class SqlLog implements Serializable{
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    private String opened_orders;
    
    private String pending_orders;
    
    private String add_to_cart;
    
    private String cart_items;

    public SqlLog() {
    }

    public SqlLog(int id, String opened_orders, String pending_orders, String add_to_cart, String cart_items) {
        this.id = id;
        this.opened_orders = opened_orders;
        this.pending_orders = pending_orders;
        this.add_to_cart = add_to_cart;
        this.cart_items = cart_items;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOpened_orders() {
        return opened_orders;
    }

    public void setOpened_orders(String opened_orders) {
        this.opened_orders = opened_orders;
    }

    public String getPending_orders() {
        return pending_orders;
    }

    public void setPending_orders(String pending_orders) {
        this.pending_orders = pending_orders;
    }

    public String getAdd_to_cart() {
        return add_to_cart;
    }

    public void setAdd_to_cart(String add_to_cart) {
        this.add_to_cart = add_to_cart;
    }

    public String getCart_items() {
        return cart_items;
    }

    public void setCart_items(String cart_items) {
        this.cart_items = cart_items;
    }
    
    
}
