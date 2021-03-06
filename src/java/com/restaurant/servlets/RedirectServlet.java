/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.restaurant.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Venkatesh
 * This is the Servlet the redirects the call to index.jsp after launching the application
 * It checks for existing Cookies in the HTTP Request and sets them as session attributes for Consequent Use
 */
public class RedirectServlet extends HttpServlet {

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
        Cookie[] cs = request.getCookies();
        if (null != cs) {
            for (Cookie c : cs) {
                if (c.getName().equalsIgnoreCase("userid")) {
                    System.out.println("Cookie found " + c.getValue());
                    request.getSession().setAttribute("userName", c.getValue());
                }
                if (c.getName().equalsIgnoreCase("cart")) {
                    System.out.println("Cookie found cart"+URLDecoder.decode(c.getValue(),"UTF-8"));
                    
                    request.getSession().setAttribute("cartJSON", URLDecoder.decode(c.getValue(),"UTF-8"));
                }
                if (c.getName().equalsIgnoreCase("user")) {
                    System.out.println("Cookie found user"+URLDecoder.decode(c.getValue(),"UTF-8"));
                    
                    request.getSession().setAttribute("user", c.getValue());
                }
            }
        }
       // request.getRequestDispatcher("index.jsp").forward(request, response);
        response.sendRedirect("index.jsp");
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
