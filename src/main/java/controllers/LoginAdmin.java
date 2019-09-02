package controllers;

import config.ConnectionPoolContextListener;
import config.MySQLConnection;
import objects.AdminUser;
import objects.Day;
import objects.TimeSlot;
import objects.User;
import beans.ListBean;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet(urlPatterns={"/admin"})
public class LoginAdmin extends HttpServlet{

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final String user = "admin";
        final String pass = "n3wLime70";

        ServletContext context = request.getServletContext();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username.equals(user) && password.equals(pass)) {
            context.setAttribute("adminUser", new AdminUser(username));
            request.getRequestDispatcher("/adminView.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/adminLogin.jsp?status=failed").forward(request, response);
        }



        //ServletContext context = request.getServletContext();
        //if (adminUser.checkValid(request.getParameter("name"), request.getParameter("password")))
//        if (MySQLConnection.adminLogin(username, request.getParameter("password")))
//        {
//            sesh.setAttribute("adminUser", new AdminUser(username));
//        }

//        // Extract the pool from the Servlet Context, reusing the one that was created
//        // in the ContextListener when the application was started
//        //DataSource pool = (DataSource) request.getServletContext().getAttribute("my-pool");
//        DataSource pool = ConnectionPoolContextListener.createConnectionPool();
//
//        boolean status = false;
//        try (Connection conn = pool.getConnection()) {
//            // PreparedStatements are compiled by the database immediately and executed at a later date.
//            // Most databases cache previously compiled queries, which improves efficiency.
//            PreparedStatement adminLoginStmt =  conn.prepareStatement(
//                    "SELECT * FROM admin WHERE username=\'admin\' AND password=\'1234\'");
//            // Execute the statement
//            ResultSet loginResults = adminLoginStmt.executeQuery();
//            // Convert a ResultSet into Vote objects
//            while (loginResults.next()) {
//                status = true;
//            }
//
//        } catch (SQLException ex) {
//            // If something goes wrong, the application needs to react appropriately. This might mean
//            // getting a new connection and executing the query again, or it might mean redirecting the
//            // user to a different page to let them know something went wrong.
//            throw new ServletException("Unable to successfully connect to the database. Please check the "
//                    + "steps in the README and try again.", ex);
//        }
//
//        // Add variables and render the page
//        request.setAttribute("status", status);
//        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }
}
