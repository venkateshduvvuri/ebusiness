/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.servlets;

import com.restaurant.dbconnection.JNDIConnectionFactory;
import com.restaurant.dbconnection.QueryExecutor;
import com.restaurant.global.GlobalConstants;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author Venkatesh
 */
public class CustomerInfoServlet extends HttpServlet {

    private List<String> home_business_customer = Arrays.asList("gender","age","income","marriage_status","business_category","gross_income") ;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println("************Request received CustomerInfoServlet.... ***************");
        String customerRequestJSON = request.getParameter("customerRequestJSON");
        JSONObject customerJSON;
        Connection conn = null;
        PreparedStatement ps = null;
        PreparedStatement homeBusinessPs = null;
        try{
            customerJSON = new JSONObject(customerRequestJSON);
            Iterator<String> itr =  customerJSON.keys();
            StringBuffer insertQueryBuffer = new StringBuffer("INSERT INTO CUSTOMER(");
            StringBuffer valuesBuffer = new StringBuffer("(");
            conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
            while(itr.hasNext()){
                String key = itr.next();
                if(this.home_business_customer.indexOf(key) == -1){
                    String value = customerJSON.getString(key);
                    insertQueryBuffer.append(key+",");
                    valuesBuffer.append("'"+value+"'"+",");
                    System.out.println("Key ::: "+key+" Value ::: "+value);
                }
            }
            (insertQueryBuffer.deleteCharAt(insertQueryBuffer.lastIndexOf(","))).append(")");
            (valuesBuffer.deleteCharAt(valuesBuffer.lastIndexOf(","))).append(")");
            (insertQueryBuffer.append(" VALUES ")).append(valuesBuffer);
            System.out.println(insertQueryBuffer);
            ps = QueryExecutor.getPreparedStatement(conn, insertQueryBuffer.toString(), null);
            if(customerJSON.getString("customer_kind").equalsIgnoreCase("Home")){
                homeBusinessPs = QueryExecutor.getPreparedStatement(conn, GlobalConstants.INSERT_HOME, null);
                homeBusinessPs.setString(1, customerJSON.getString("customer_id"));
                homeBusinessPs.setString(2, customerJSON.getString("marriage_status"));
                homeBusinessPs.setString(3, customerJSON.getString("gender"));
                homeBusinessPs.setString(4, customerJSON.getString("age"));
                homeBusinessPs.setString(5, customerJSON.getString("income"));
            }
            else{
                homeBusinessPs = QueryExecutor.getPreparedStatement(conn, GlobalConstants.INSERT_BUSINESS, null);
                homeBusinessPs.setString(1, customerJSON.getString("customer_id"));
                homeBusinessPs.setString(2, customerJSON.getString("business_category"));
                homeBusinessPs.setString(3, customerJSON.getString("gross_income"));
            }
            if(QueryExecutor.executeQuery(ps)){
                if(!QueryExecutor.executeQuery(homeBusinessPs)){
                    System.out.println("Error Inserting into Home or Business Table");
                    conn.rollback();
                }
            }
            else{
                System.out.println("Failed Adding a New Customer");
                conn.rollback();
            }
            conn.commit();
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        finally{
            QueryExecutor.closeObjects(null, ps, null);
            QueryExecutor.closeObjects(null, homeBusinessPs, conn);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
