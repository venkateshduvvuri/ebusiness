/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.servlets;

import com.restaurant.adapter.OrderRequest;
import com.restaurant.beans.ProductDetails;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
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
public class OrderRequestServlet extends HttpServlet {

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
        System.out.println("Request received .... ***************");
        String orderRequestJSON = request.getParameter("orderRequestJSON");
        JSONObject orderJSON;
        try{
            orderJSON = new JSONObject(orderRequestJSON);
            String userId = (String)request.getSession().getAttribute("user");
            JSONArray orderDetailsArray = orderJSON.getJSONArray("orderdetails");
            int items = orderDetailsArray.length();
            List<ProductDetails> productsList = new ArrayList<>();
            double orderAmount = 0;
            for(int i=0; i<items; i++){
                String productName = orderDetailsArray.getJSONObject(i).getString("productname");
                String productId = orderDetailsArray.getJSONObject(i).getString("productId");
                int quantity = orderDetailsArray.getJSONObject(i).getInt("quantity");
                double price = orderDetailsArray.getJSONObject(i).getDouble("price");
                orderAmount = orderAmount + (price*quantity);
                ProductDetails pd = new ProductDetails(productId, productName, quantity, price);
                productsList.add(pd);
            }
            OrderRequest or = new OrderRequest(productsList, orderAmount, userId);
            if(or.placeOrder()){
                System.out.println("Order has been Placed Succefully...");
                out.println("Successful");
            }
        }
        catch(Exception ex){
            ex.printStackTrace();
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
