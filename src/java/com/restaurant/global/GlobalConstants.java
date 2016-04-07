/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.global;

/**
 *
 * @author Venkatesh
 */
public class GlobalConstants {
    
    public static final String USER_LOGIN_QUERY = "SELECT USERNAME,PASSWORD FROM USERDETAILS WHERE USERNAME=? and PASSWORD = ?";
    
    public static final String ORDER_QUERY = "INSERT INTO ORDERS(ORDERID, USERNAME, ORDERDATE, ORDERAMOUNT, ORDERSTATUS) VALUES (?, ?, ?, ?, ?)";
    
    public static final String ORDER_DETAILS_QUERY = "INSERT INTO ORDERDETAILS(ORDERID, PRODUCTNAME, QUANTITY, PRICE) VALUES (?, ?, ?, ?)";
    
    public static final String UPDATE_STATUS_QUERY = "UPDATE ORDERS SET ORDERSTATUS = ? WHERE ORDERID = ?";
    
    public static final String PRODUCT_FETCH_QUERY = "SELECT NAME,DESCRIPTION,PRICE,IMAGE_URL FROM PRODUCT WHERE INVENTORY_AMOUNT > 0 ORDER BY NAME ASC";
    
    public static final String ORDER_STATUS_PLACED = "Order Placed";
    
    public static final String ORDER_STATUS_INPROCESS = "Food is being prepared";
    
    public static final String ORDER_STATUS_READY = "Food Ready";
    
}
