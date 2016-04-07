/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.beans;

import com.restaurant.dbconnection.JNDIConnectionFactory;
import com.restaurant.dbconnection.QueryExecutor;
import com.restaurant.global.GlobalConstants;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Venkatesh
 */
public class UserBean {
    
    private String userName;
    
    private String password;

    public UserBean(String userName, String password) {
        this.userName = userName;
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public boolean login(){
        Connection conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
        String query = GlobalConstants.USER_LOGIN_QUERY;
        String[][] params = {
            {String.valueOf(Types.VARCHAR),this.userName},
            {String.valueOf(Types.VARCHAR),this.password}
        };
        PreparedStatement ps = QueryExecutor.getPreparedStatement(conn, query, params);
        ResultSet rs = QueryExecutor.executePSQuery(ps);
        try {
            while(rs.next()){
                System.out.println("Login Successful for the user ::: "+this.userName);
                return true;
            }
        } catch (SQLException ex) {
            System.out.println("Login failed for the user ::: "+this.userName);
            ex.printStackTrace();
        }
        finally{
            QueryExecutor.closeObjects(rs, ps, conn);
        }
        System.out.println("Login failed for the user ::: "+this.userName);
        return false;
    }
}
