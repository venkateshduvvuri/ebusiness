/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.servlets;

import com.restaurant.beans.UserBean;
import com.restaurant.dbconnection.JNDIConnectionFactory;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;


/**
 *
 * @author Venkatesh
 * This Servlet is used to Login into the application. It also sets the Login information 
 * and Cart information in the Cookies which can be used later.
 */
public class LoginServlet extends HttpServlet {

    @Override
    public void init() throws ServletException {
        JNDIConnectionFactory.initializeDataSource("mypool");
        Connection conn = JNDIConnectionFactory.getConnectionFromJNDIPool();
        System.out.println("Connection is  ::: "+conn);
        try {
            conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    
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
        response.setHeader( "Pragma", "no-cache" );
        response.setHeader( "Cache-Control", "no-cache" );
        response.setDateHeader( "Expires", 0 );
        //response.sendRedirect("index.jsp");
        PrintWriter out = response.getWriter();
        System.out.println("Request received .... ***************");
        String loginRequestJSON = request.getParameter("loginRequestJSON");
        JSONObject loginJSON;
        try{
            loginJSON = new JSONObject(loginRequestJSON);
            if(loginJSON.getString("requestType").equalsIgnoreCase("login")){
                String userName = "";
                boolean loginStatus = false;
                String userId = loginJSON.getString("userId");
                String password = loginJSON.getString("password");
                if(!userId.equalsIgnoreCase("admin")){
                    UserBean userBean = new UserBean(userId, password);
                    loginStatus = userBean.login();
                    userName = userBean.getUserName();
                }
                if(userId.equalsIgnoreCase("admin") && password.equalsIgnoreCase("admin")){
                    loginStatus = true;
                    userName = "admin";
                }
                if(loginStatus){
                    HttpSession session = request.getSession();
                    session.setAttribute("userName", userName);
                    session.setAttribute("user", userId);
                    Cookie c = new Cookie("userid", userName);
                    c.setMaxAge(24*60*60);
                    c.setPath("/");
                    response.addCookie(c);
                    
                    Cookie c1 = new Cookie("user", userId);
                    c1.setMaxAge(24*60*60);
                    c1.setPath("/");
                    response.addCookie(c1);
                    System.out.println("Login Successful");
                    out.println("Successful");
                }
            }
            else{
                HttpSession session = request.getSession();
                Cookie[] cs = request.getCookies();
                for (Cookie c : cs) {
                    if (c.getName().equalsIgnoreCase("userid")) {
                        System.out.println("Cookie found " + c.getValue());
                        c.setMaxAge(0);
                        c.setValue(null);
                        c.setPath("/");
                        response.addCookie(c);
                    }
                    if (c.getName().equalsIgnoreCase("cart")) {
                        System.out.println("Cookie found cart");
                        c.setMaxAge(0);
                        c.setValue(null);
                        c.setPath("/");
                        response.addCookie(c);
                    }
                    if (c.getName().equalsIgnoreCase("user")) {
                        System.out.println("Cookie found cart");
                        c.setMaxAge(0);
                        c.setValue(null);
                        c.setPath("/");
                        response.addCookie(c);
                    }
                }
                session.invalidate();
                System.out.println("Logout Successful...Session Invalidated");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
