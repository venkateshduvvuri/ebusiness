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
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Venkatesh
 */
public class ProductManagementServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        response.setHeader( "Pragma", "no-cache" );
        response.setHeader( "Cache-Control", "no-cache" );
        response.setDateHeader( "Expires", 0 );
        PrintWriter out = response.getWriter();
        String productRequestJSON = request.getParameter("productRequestJSON");
        JSONObject productRequestJSONObj;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            productRequestJSONObj = new JSONObject(productRequestJSON);
            String requestType = productRequestJSONObj.getString("requestType");
            if(requestType.equalsIgnoreCase("FetchProducts")){
                conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
                ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.PRODUCT_FETCH_QUERY, null);
                rs = QueryExecutor.executePSQuery(ps);
                JSONArray productsArray = new JSONArray();
                while(rs.next()){
                    JSONObject productJSONObj = new JSONObject();
                    productJSONObj.put("productName", rs.getString("NAME"));
                    productJSONObj.put("productDescription", null == rs.getString("DESCRIPTION") ? "" : rs.getString("DESCRIPTION"));
                    productJSONObj.put("productPrice", "$"+rs.getString("PRICE"));
                    productJSONObj.put("url", null == rs.getString("IMAGE_URL") ? "" : rs.getString("IMAGE_URL"));
                    productsArray.put(productJSONObj);
                }
                System.out.println("Final JSON ::: "+productsArray.toString());
                request.getSession().setAttribute("allProductsJSON", productsArray.toString());
                out.println(productsArray.toString());
            }
            if(requestType.equalsIgnoreCase("SearchProducts")){
                conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
                ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.SEARCH_QUERY, null);
                rs = QueryExecutor.executePSQuery(ps);
                JSONArray productsArray = new JSONArray();
                while(rs.next()){
                    JSONObject productJSONObj = new JSONObject();
                    productJSONObj.put("productName", rs.getString("NAME"));
                    productJSONObj.put("productDescription", null == rs.getString("DESCRIPTION") ? "" : rs.getString("DESCRIPTION"));
                    productJSONObj.put("productPrice", "$"+rs.getString("PRICE"));
                    productJSONObj.put("url", null == rs.getString("IMAGE_URL") ? "" : rs.getString("IMAGE_URL"));
                    productsArray.put(productJSONObj);
                }
                System.out.println("Final JSON ::: "+productsArray.toString());
                request.getSession().setAttribute("allProductsJSON", productsArray.toString());
                out.println(productsArray.toString());
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
        }
        finally{
            QueryExecutor.closeObjects(rs, ps, conn);
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
