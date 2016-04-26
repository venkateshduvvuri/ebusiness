/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.global;

/**
 *
 * @author Venkatesh
 * This is a Global Constants File which contains all the Constants used across the Application.
 */
public class GlobalConstants {
    
    public static final String USER_LOGIN_QUERY = "SELECT CUSTOMER_NAME,CUSTOMER_ID,CUSTOMER_PASSWORD FROM CUSTOMER WHERE CUSTOMER_ID = ? and CUSTOMER_PASSWORD = ?";
    
    public static final String ORDER_QUERY = "INSERT INTO TRANSACTIONS(CUSTOMER_ID, ORDER_DATE, ORDER_TOTAL, SALESPERSON_ID, ORDER_STATUS) VALUES (?, ?, ?, ?, ?)";
    
    public static final String ORDER_DETAILS_QUERY = "INSERT INTO ORDERS(ORDER_ID, PRODUCT_ID, PRODUCT_QUANTITY, PRODUCT_PRICE) VALUES (?, ?, ?, ?)";
    
    public static final String ORDER_STATUS_QUERY = "SELECT ORDER_STATUS FROM TRANSACTIONS WHERE ORDER_ID = ?" ;
    
    public static final String INSERT_HOME = "INSERT INTO CUSTOMER_HOME (CUSTOMER_ID,MARRIAGE_STATUS,GENDER,AGE,INCOME) VALUES (?,?,?,?,?)";
    
    public static final String INSERT_BUSINESS = "INSERT INTO CUSTOMER_BUSINESS (CUSTOMER_ID,BUSINESS_CATEGORY,GROSS_INCOME) VALUES (?,?,?)";
    
    public static final String UPDATE_STATUS_QUERY = "UPDATE TRANSACTIONS SET ORDER_STATUS = ? WHERE ORDER_ID = ?";
    
    public static final String PRODUCT_FETCH_QUERY = "SELECT PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,PRODUCT_PRICE,IMAGE_URL,INVENTORY_AMOUNT FROM PRODUCT WHERE INVENTORY_AMOUNT > 0 ORDER BY PRODUCT_NAME ASC";
    
    public static final String ADD_NEW_PRODUCT = "INSERT INTO PRODUCT(PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,INVENTORY_AMOUNT,PRODUCT_PRICE,PRODUCT_KIND,IMAGE_URL) VALUES (?,?,?,?,?,?,?)";
    
    public static final String DELETE_PRODUCT = "DELETE FROM PRODUCT WHERE PRODUCT_ID = ?";
    
    public static final String GET_PRODUCT = "SELECT * FROM PRODUCT WHERE PRODUCT_ID = ?";
    
    public static final String UPDATE_PRODUCT = "UPDATE PRODUCT SET PRODUCT_NAME = ?,PRODUCT_DESCRIPTION = ?,PRODUCT_PRICE = ?,IMAGE_URL = ?,INVENTORY_AMOUNT = ?,PRODUCT_KIND=? WHERE PRODUCT_ID = ?";
    
    public static final String ORDER_STATUS_PLACED = "Order Placed";
    
    public static final String ORDER_STATUS_INPROCESS = "2";
    
    public static final String ORDER_STATUS_READY = "3";
    
    public static final String SEARCH_QUERY = "SELECT PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,PRODUCT_PRICE,IMAGE_URL,INVENTORY_AMOUNT FROM PRODUCT WHERE INVENTORY_AMOUNT > 0 and UPPER(PRODUCT_NAME) LIKE UPPER(?) ORDER BY PRODUCT_NAME ASC";
    
    public static final String SEARCH_QUERY_CAT = "SELECT PRODUCT_ID,PRODUCT_NAME,PRODUCT_DESCRIPTION,PRODUCT_PRICE,IMAGE_URL,INVENTORY_AMOUNT FROM PRODUCT WHERE INVENTORY_AMOUNT > 0 and UPPER(PRODUCT_NAME) LIKE UPPER(?) and UPPER(PRODUCT_KIND) = ? ORDER BY PRODUCT_NAME ASC";
    
    public static final String SALES_BY_PRODUCT = "SELECT PRODUCT.PRODUCT_NAME AS 'Product Name',SUM(ORDERS.PRODUCT_QUANTITY) AS 'Quantity Ordered',SUM(ORDERS.PRODUCT_QUANTITY*ORDERS.PRODUCT_PRICE) AS 'Total Profit' FROM ORDERS JOIN PRODUCT ON ORDERS.PRODUCT_ID=PRODUCT.PRODUCT_ID GROUP BY ORDERS.PRODUCT_ID";
    
    public static final String CATEGORY_TOP = "SELECT PRODUCT.PRODUCT_KIND AS 'Category', SUM(ORDERS.PRODUCT_QUANTITY) AS 'Quantity Ordered' FROM ORDERS JOIN PRODUCT ON orders.product_id = product.product_id  GROUP BY PRODUCT.PRODUCT_KIND ORDER BY `Quantity Ordered` DESC";
    
    public static final String SALES_BY_REGION = "SELECT REGION.REGION_ID AS 'REGION ID',REGION.REGION_NAME AS 'REGION NAME', SUM(ORDERS.PRODUCT_QUANTITY) AS 'NO. OF PRODUCTS SOLD'" +
                                                 " FROM TRANSACTIONS,ORDERS,EMPLOYEE_STORE,REGION " +
                                                 " WHERE EMPLOYEE_STORE.EMPLOYEE_ID=TRANSACTIONS.SALESPERSON_ID AND EMPLOYEE_STORE.REGION_ID=REGION.REGION_ID AND TRANSACTIONS.ORDER_ID=ORDERS.ORDER_ID " +
                                                 " GROUP BY REGION.REGION_ID,REGION.REGION_NAME";
    
    public static final String MY_ORDERS = "SELECT TRANSACTIONS.ORDER_ID AS 'ORDER ID',ORDERS.PRODUCT_ID AS 'PRODUCT ID',PRODUCT.PRODUCT_NAME AS 'PRODUCT NAME', SUM(ORDERS.PRODUCT_QUANTITY) AS 'QUANTITY ORDERED' FROM TRANSACTIONS,ORDERS,PRODUCT  WHERE TRANSACTIONS.ORDER_ID=ORDERS.ORDER_ID AND ORDERS.PRODUCT_ID=PRODUCT.PRODUCT_ID AND TRANSACTIONS.CUSTOMER_ID= ? GROUP BY ORDERS.ORDER_ID";
    
    public static final String MY_ORDERS_VIEW = "SELECT `ORDER ID`,`PRODUCT ID`,`PRODUCT NAME`,`QUANTITY ORDERED` FROM USER_ORDER WHERE CUSTOMER_ID = ? ORDER BY `ORDER ID`";
    
    
    public static final String SALES_ID = "9993";
}
