package controllers;

import config.email.EmailService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;


@WebServlet(urlPatterns={"/emailDay"})
public class EmailDay extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        ServletContext context = request.getServletContext();
//        String takings = (String) context.getAttribute("dayTakings");
//
//        emailTakings(takings);
//
        try {
            EmailService.sendEmail("dylancawsey@gmail.com");
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

    public void emailTakings(String takings)
    {

    }
}
