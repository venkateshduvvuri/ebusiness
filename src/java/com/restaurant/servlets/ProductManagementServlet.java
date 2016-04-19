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
import java.sql.ResultSetMetaData;
import java.sql.Types;
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
            conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
            if(requestType.equalsIgnoreCase("FetchProducts")){
                ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.PRODUCT_FETCH_QUERY, null);
                rs = QueryExecutor.executePSQuery(ps);
                JSONArray productsArray = new JSONArray();
                while(rs.next()){
                    JSONObject productJSONObj = new JSONObject();
                    productJSONObj.put("productName", rs.getString("PRODUCT_NAME"));
                    productJSONObj.put("productDescription", null == rs.getString("PRODUCT_DESCRIPTION") ? "" : rs.getString("PRODUCT_DESCRIPTION"));
                    productJSONObj.put("productPrice", "$"+rs.getString("PRODUCT_PRICE"));
                    productJSONObj.put("url", null == rs.getString("IMAGE_URL") ? "" : rs.getString("IMAGE_URL"));
                    productJSONObj.put("inventory_amount", rs.getString("INVENTORY_AMOUNT"));
                    productJSONObj.put("productId", rs.getString("PRODUCT_ID"));
                    productsArray.put(productJSONObj);
                }
                System.out.println("Final JSON ::: "+productsArray.toString());
                request.getSession().setAttribute("allProductsJSON", productsArray.toString());
                out.println(productsArray.toString());
            }
            else if(requestType.equalsIgnoreCase("SearchProducts")){
                System.out.println("Search Query ::: "+productRequestJSONObj.getString("searchQuery"));
                String productCat = productRequestJSONObj.getString("searchCategory");
                
                if(productCat.equalsIgnoreCase("ALL")){
                    ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.SEARCH_QUERY, null);
                    ps.setString(1, "%"+productRequestJSONObj.getString("searchQuery")+"%");
                }
                else{
                    ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.SEARCH_QUERY_CAT, null);
                    ps.setString(1, "%"+productRequestJSONObj.getString("searchQuery")+"%");
                    ps.setString(2, productCat.toUpperCase());
                }
                rs = QueryExecutor.executePSQuery(ps);
                JSONArray productsArray = new JSONArray();
                while(rs.next()){
                    JSONObject productJSONObj = new JSONObject();
                    productJSONObj.put("productName", rs.getString("PRODUCT_NAME"));
                    productJSONObj.put("productDescription", null == rs.getString("PRODUCT_DESCRIPTION") ? "" : rs.getString("PRODUCT_DESCRIPTION"));
                    productJSONObj.put("productPrice", "$"+rs.getString("PRODUCT_PRICE"));
                    productJSONObj.put("url", null == rs.getString("IMAGE_URL") ? "" : rs.getString("IMAGE_URL"));
                    productJSONObj.put("inventory_amount", rs.getString("INVENTORY_AMOUNT"));
                    productJSONObj.put("productId", rs.getString("PRODUCT_ID"));
                    productsArray.put(productJSONObj);
                }
                System.out.println("Final JSON ::: "+productsArray.toString());
                request.getSession().setAttribute("allProductsJSON", productsArray.toString());
                out.println(productsArray.toString());
            }
            else if(requestType.equalsIgnoreCase("AddNewProduct")){
                JSONObject newProductJSONObj = productRequestJSONObj.getJSONObject("productJSON");
                String[][] newProductParams = {
                    {String.valueOf(Types.VARCHAR),newProductJSONObj.getString("product_id")},
                    {String.valueOf(Types.VARCHAR),newProductJSONObj.getString("product_name")},
                    {String.valueOf(Types.VARCHAR),newProductJSONObj.getString("product_description")},
                    {String.valueOf(Types.VARCHAR),newProductJSONObj.getString("inventory_amount")},
                    {String.valueOf(Types.VARCHAR),newProductJSONObj.getString("product_price")},
                    {String.valueOf(Types.VARCHAR),newProductJSONObj.getString("product_kind")},
                    {String.valueOf(Types.VARCHAR),newProductJSONObj.getString("image_url")}
                };
                

                ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.ADD_NEW_PRODUCT, newProductParams);
                if(QueryExecutor.executeQuery(ps)){
                    System.out.println("New Product Added Successfully.");
                    conn.commit();
                    out.println("Successful");
                }
                else{
                    System.out.println("Failed Adding New Product.");
                    conn.rollback();
                    out.println("Failed");
                }
                
            }
            else if(requestType.equalsIgnoreCase("SalesAggregate")){
                 String aggregationType = productRequestJSONObj.getString("aggregationType");
                 if(aggregationType.equalsIgnoreCase("SALES_BY_PRODUCT")){
                    ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.SALES_BY_PRODUCT, null);
                 }
                 else if(aggregationType.equalsIgnoreCase("CATEGORY_TOP")){
                     ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.CATEGORY_TOP, null);
                 }    
                 else if(aggregationType.equalsIgnoreCase("SALES_BY_REGION")){
                     ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.SALES_BY_REGION, null);
                 }
                 else if(aggregationType.equalsIgnoreCase("MY_ORDERS")){
                     ps = QueryExecutor.getPreparedStatement(conn, GlobalConstants.MY_ORDERS_VIEW, null);
                     ps.setString(1, (String)request.getSession().getAttribute("user"));
                 } 
                 rs = QueryExecutor.executePSQuery(ps);
                 JSONArray aggregateJSONArray = new JSONArray();
                 ResultSetMetaData rsmd = rs.getMetaData();
                 int columnCount = rsmd.getColumnCount();
                 
                 JSONObject colNamesJSON = new JSONObject();
                 JSONArray colnamesArray = new JSONArray();
                 for(int i=1 ; i<columnCount+1; i++){
                     colnamesArray.put(rsmd.getColumnLabel(i));
                 }
                 colNamesJSON.put("columnNames", colnamesArray);
                 
                 
                 JSONObject colValuesJSON = new JSONObject();
                 JSONArray colValuesArray = new JSONArray();
                 while(rs.next()){
                     JSONArray colValuesPerRow = new JSONArray();
                     for(int j=1; j<columnCount+1; j++){
                         colValuesPerRow.put(rs.getString(j));
                     }
                     colValuesArray.put(colValuesPerRow);
                 }
                 colValuesJSON.put("columnValues", colValuesArray);
                 aggregateJSONArray.put(colNamesJSON);
                 aggregateJSONArray.put(colValuesJSON);
                 out.println(aggregateJSONArray.toString());
                 System.out.println(aggregateJSONArray.toString());
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
