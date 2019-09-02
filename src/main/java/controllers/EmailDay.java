package controllers;

import config.email.EmailService;
import objects.Day;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.Date;


@WebServlet(urlPatterns={"/emailDay"})
public class EmailDay extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate admin user server side
        ServletContext context = request.getServletContext();
        if (context.getAttribute("adminUser") != null) {
            Day day = (Day) context.getAttribute("day");
            Date date = new Date();
            String emailContent = "<h2>Cost Analytics - " +date.toString() +"</h2>\n" +day.getHtmlAnalyticsOutput();
            try {
                EmailService.sendEmail("dylancawsey@gmail.com", emailContent);
            } catch (Exception ex) {
                ex.printStackTrace();
            }

            request.getRequestDispatcher("/index.jsp").forward(request,response);
        } else {
            request.getRequestDispatcher("/adminLogin.jsp").forward(request,response);
        }
    }
}
