/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.adapter;

import com.restaurant.beans.ProductDetails;
import com.restaurant.dbconnection.JNDIConnectionFactory;
import com.restaurant.dbconnection.QueryExecutor;
import com.restaurant.global.GlobalConstants;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Venkatesh
 * This Class is used to place an order request. It Encapsulates the Cart Details and Persists it to the database.
 * It Also Creates a Thread which Updates the Order Status in the Database.
 */
public class OrderRequest {
    
    private List<ProductDetails> order;
    
    private double orderAmount;
    
    private String userName;
    
    private int orderId;

    
    public OrderRequest(List<ProductDetails> order, double orderAmount, String userName) {
        this.order = order;
        this.orderAmount = orderAmount;
        this.userName = userName;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public boolean placeOrder() throws SQLException{
        
        String[][] params = {
            {String.valueOf(Types.VARCHAR),String.valueOf(this.userName)},
            {String.valueOf(Types.DATE),""},
            {String.valueOf(Types.DOUBLE),String.valueOf(this.orderAmount)},
            {String.valueOf(Types.VARCHAR),GlobalConstants.SALES_ID},
            {String.valueOf(Types.VARCHAR),"1"}
        };
        Connection conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
        PreparedStatement ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.ORDER_QUERY, params);
        if(QueryExecutor.executeQuery(ps)){
            ResultSet rs =  ps.getGeneratedKeys();
             rs.next();
             int orderId = rs.getInt(1);
             this.setOrderId(orderId);
            QueryExecutor.closeObjects(null, ps, null);
            for(ProductDetails product : this.order){
                String[][] queryParams = {
                    {String.valueOf(Types.INTEGER),String.valueOf(orderId)},
                    {String.valueOf(Types.VARCHAR),String.valueOf(product.getProductId())},
                    {String.valueOf(Types.INTEGER),String.valueOf(product.getQuantity())},
                    {String.valueOf(Types.DOUBLE),String.valueOf(product.getPrice())},
                };
                PreparedStatement ps1 = QueryExecutor.getPreparedStatement(conn, GlobalConstants.ORDER_DETAILS_QUERY, queryParams);
                if(!QueryExecutor.executeQuery(ps1)){
                    System.out.println("Error Updating Order Details. Query Execution Failed.");
                    conn.rollback();
                    QueryExecutor.closeObjects(null, ps1, conn);
                    return false;
                }    
                QueryExecutor.closeObjects(null, ps1, null);
            }
            System.out.println("Order has been Placed Succefully...");
            conn.commit();
            QueryExecutor.closeObjects(null, null, conn);
            Thread t = new Thread(new OrderUpdateThread(orderId));
            t.start();
            return true;
        }
        else{
            System.out.println("Error occurred while Placing the Order. Query Execution Failed.");
            conn.rollback();
            QueryExecutor.closeObjects(null, ps, conn);
            return false;
        }
    }
    
    /*
    * This is a dummy thread which will Update the Order Status in the DataBase. Sleep Time is 10Seconds.
    * So After 20 Seconds, the order status will be changed to "Ready".
    */
    class OrderUpdateThread implements Runnable{

        private long orderid;
        
        public OrderUpdateThread(long orderid){
            this.orderid = orderid;
        }
        @Override
        public void run() {
            Connection conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
            PreparedStatement ps = null;
            PreparedStatement ps1 = null ;
            try {
                System.out.println("Order Update Thread has been initialized for the Order ::: "+this.orderid);
                Thread.sleep(7000);
                ps = QueryExecutor.getPreparedStatement(conn,GlobalConstants.UPDATE_STATUS_QUERY, new String[][]{
                    {String.valueOf(Types.VARCHAR),GlobalConstants.ORDER_STATUS_INPROCESS},
                    {String.valueOf(Types.VARCHAR),String.valueOf(this.orderid)}
                });
                QueryExecutor.executeQuery(ps);
                conn.commit();
                Thread.sleep(10000);
                ps1 = QueryExecutor.getPreparedStatement(conn, GlobalConstants.UPDATE_STATUS_QUERY, new String[][]{
                    {String.valueOf(Types.VARCHAR),GlobalConstants.ORDER_STATUS_READY},
                    {String.valueOf(Types.VARCHAR),String.valueOf(this.orderid)}
                });
                QueryExecutor.executeQuery(ps1);
                conn.commit();
            } catch (InterruptedException ex) {
                System.out.println("Exception Occurred in Order Update Thread for the Order ::: "+this.orderid);
                ex.printStackTrace();
            } catch (SQLException sqex) {
                System.out.println("SQLException Occurred in Order Update Thread for the Order ::: "+this.orderid);
                sqex.printStackTrace();
            }
            finally{
                QueryExecutor.closeObjects(null, ps, null);
                QueryExecutor.closeObjects(null, ps1, conn);
            }
        }
    }
}
