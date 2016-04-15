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
    
    public static final String USER_LOGIN_QUERY = "SELECT CUSTOMER_NAME,CUSTOMER_ID,CUSTOMER_PASSWORD FROM CUSTOMER WHERE CUSTOMER_ID = ? and CUSTOMER_PASSWORD = ?";
    
    public static final String ORDER_QUERY = "INSERT INTO ORDERS(ORDERID, USERNAME, ORDERDATE, ORDERAMOUNT, ORDERSTATUS) VALUES (?, ?, ?, ?, ?)";
    
    public static final String ORDER_DETAILS_QUERY = "INSERT INTO ORDERDETAILS(ORDERID, PRODUCTNAME, QUANTITY, PRICE) VALUES (?, ?, ?, ?)";
    
    public static final String INSERT_HOME = "INSERT INTO CUSTOMER_HOME (CUSTOMER_ID,MARRIAGE_STATUS,GENDER,AGE,INCOME) VALUES (?,?,?,?,?)";
    
    public static final String INSERT_BUSINESS = "INSERT INTO CUSTOMER_BUSINESS (CUSTOMER_ID,BUSINESS_CATEGORY,GROSS_INCOME) VALUES (?,?,?)";
    
    public static final String UPDATE_STATUS_QUERY = "UPDATE ORDERS SET ORDERSTATUS = ? WHERE ORDERID = ?";
    
    public static final String PRODUCT_FETCH_QUERY = "SELECT PRODUCT_NAME,PRODUCT_DESCRIPTION,PRODUCT_PRICE,IMAGE_URL,INVENTORY_AMOUNT FROM PRODUCT WHERE INVENTORY_AMOUNT > 0 ORDER BY PRODUCT_NAME ASC";
    
    public static final String ORDER_STATUS_PLACED = "Order Placed";
    
    public static final String ORDER_STATUS_INPROCESS = "Food is being prepared";
    
    public static final String ORDER_STATUS_READY = "Food Ready";
    
    public static final String SEARCH_QUERY = "SELECT PRODUCT_NAME,PRODUCT_DESCRIPTION,PRODUCT_PRICE,IMAGE_URL,INVENTORY_AMOUNT FROM PRODUCT WHERE INVENTORY_AMOUNT > 0 and UPPER(PRODUCT_NAME) LIKE UPPER(?) ORDER BY PRODUCT_NAME ASC";
    
}
