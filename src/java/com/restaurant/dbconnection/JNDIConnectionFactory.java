/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.dbconnection;

import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Venkatesh
 * This Class is used to Initialize the JNDI Connection Pool on Server Startup.
 * The initializeDataSource Method is called in the init Method of the LoginServlet
 * So, the static Variable JNDIDataSource is initialized and used.
 */
public class JNDIConnectionFactory {
    
    private static DataSource JNDIDataSource;
    
    public static String defaultJNDIName = "mypool";
    
    public static boolean initializeDataSource(String JNDIName){
        if(JNDIName == null){
            JNDIName = defaultJNDIName;
        }
        InitialContext initialContext;
        try {
            initialContext = new InitialContext();
            Context ctx = (Context)initialContext.lookup("java:comp/env");
            JNDIDataSource = (DataSource) ctx.lookup(JNDIName);
        } catch (NamingException ex) {
            System.out.println("Naming Exception occurred while trying to fetch the DataSource...");
            ex.printStackTrace();
            return false;
        }
        
        if(JNDIDataSource == null){
            System.out.println("Error Initializing JNDI DataSource...Connection Pooling has Failed.");
            return false;
        }
        return true;
    }
    /*
    * This Method is used to return a Connection Object from the JNDI Connection Pool
    */
    public static Connection getConnectionFromJNDIPool(){
        try{
           Connection conn = JNDIDataSource.getConnection();
           conn.setAutoCommit(false);
           return conn;
        }
        catch(SQLException sqlex){
            System.out.println("SQLException occurred while attempting to get a Connection to the Database");
            sqlex.printStackTrace();
            return null;
        }
    }
}
