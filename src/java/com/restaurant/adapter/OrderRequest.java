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
import java.sql.SQLException;
import java.sql.Types;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Venkatesh
 */
public class OrderRequest {
    
    private List<ProductDetails> order;
    
    private double orderAmount;
    
    private String userName;

    public OrderRequest(List<ProductDetails> order, double orderAmount, String userName) {
        this.order = order;
        this.orderAmount = orderAmount;
        this.userName = userName;
    }
    
    public boolean placeOrder() throws SQLException{
        long orderid = System.currentTimeMillis();
        String[][] params = {
            {String.valueOf(Types.BIGINT),String.valueOf(orderid)},
            {String.valueOf(Types.VARCHAR),String.valueOf(this.userName)},
            {String.valueOf(Types.DATE),""},
            {String.valueOf(Types.DOUBLE),String.valueOf(this.orderAmount)}
        };
        Connection conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
        PreparedStatement ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.ORDER_QUERY, params);
        if(QueryExecutor.executeQuery(ps)){
            QueryExecutor.closeObjects(null, ps, null);
            for(ProductDetails product : this.order){
                String[][] queryParams = {
                    {String.valueOf(Types.BIGINT),String.valueOf(orderid)},
                    {String.valueOf(Types.VARCHAR),product.getProductName()},
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
            Thread t = new Thread(new OrderUpdateThread(orderid));
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
                Thread.sleep(5000);
                ps = QueryExecutor.getPreparedStatement(conn,GlobalConstants.UPDATE_STATUS_QUERY, new String[][]{
                    {String.valueOf(Types.VARCHAR),GlobalConstants.ORDER_STATUS_INPROCESS},
                    {String.valueOf(Types.BIGINT),String.valueOf(this.orderid)}
                });
                QueryExecutor.executePSQuery(ps);
                conn.commit();
                Thread.sleep(5000);
                ps1 = QueryExecutor.getPreparedStatement(conn, GlobalConstants.UPDATE_STATUS_QUERY, new String[][]{
                    {String.valueOf(Types.VARCHAR),GlobalConstants.ORDER_STATUS_READY},
                    {String.valueOf(Types.BIGINT),String.valueOf(this.orderid)}
                });
                QueryExecutor.executePSQuery(ps1);
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
