/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.dbconnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;


/**
 *
 * @author Venkatesh
 * This Class is Generic Query Executor. It is Designed to Execute 
 * Prepredstatements and close Connection Related Objects after they are used.
 */
public class QueryExecutor {
    
    public static ResultSet executePSQuery(PreparedStatement ps){
        
        try {
            ResultSet rs = ps.executeQuery();
            return rs;
        }
        catch (SQLException sqlex) {
            System.out.println("SQLException occurred while executing the query...");
            sqlex.printStackTrace();
            return null;
        }
        catch(Exception ex){
            System.out.println("SQLException occurred while executing the query...");
            ex.printStackTrace();
            return null;
        }
    }
    
    public static boolean executeQuery(PreparedStatement ps){
        
        try {
            ps.execute();
            return true;
        }
        catch (SQLException sqlex) {
            System.out.println("SQLException occurred while executing the query...");
            sqlex.printStackTrace();
            return false;
        }
        catch(Exception ex){
            System.out.println("SQLException occurred while executing the query...");
            ex.printStackTrace();
            return false;
        }
    }
    
    public static PreparedStatement getPreparedStatement(Connection conn, String query, String[][] params) {
        PreparedStatement ps;
        try{
            ps = conn.prepareStatement(query,Statement.RETURN_GENERATED_KEYS);
            if(null != params){
                for(int i=0; i < params.length; i++){

                String[] paramsArray = params[i];
                int type = Integer.valueOf(paramsArray[0]);
                String value = paramsArray[1];
                System.out.println("Type ::: "+ type);
                System.out.println("Value ::: "+ value);
                    switch(type){
                        case Types.VARCHAR:
                            ps.setString(i+1, value);
                            break;
                        case Types.INTEGER:
                            ps.setInt(i+1, Integer.valueOf(value));
                            break;
                        case Types.BIGINT:
                            ps.setLong(i+1, Long.valueOf(value));
                            break;
                        case Types.DATE:
                            ps.setDate(i+1, new java.sql.Date(System.currentTimeMillis()));
                            break;   
                        case Types.DOUBLE:
                            ps.setDouble(i+1, Double.valueOf(value));
                            break;
                    }
                }
            }
            return ps;
        }
        catch(Exception exp){
            exp.printStackTrace();
            return null;
        }
    }
    
    public static void closeObjects(ResultSet rs, PreparedStatement ps, Connection conn){
        try{
            if(null != rs){
                rs.close();
            }
            if(null != ps){
                ps.close();
            }
            if(null != conn){
                conn.close();
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
    }
}
