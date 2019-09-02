package controllers;

import objects.AdminUser;
import objects.Day;
import objects.TimeSlot;
import objects.User;
import beans.ListBean;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;


@WebServlet(urlPatterns={"/openDay"})
public class OpenDay extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate admin user server side
        ServletContext context = request.getServletContext();
        if (context.getAttribute("adminUser") != null) {
            boolean isWeekend = Boolean.valueOf(request.getParameter("isWeekend"));
            Day day = new Day(isWeekend);
            context.setAttribute("day", day);
            boolean isClosed = false;
            context.setAttribute("isClosed", isClosed);
            HttpSession sesh = request.getSession();
            sesh.invalidate();
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        } else {
            request.getRequestDispatcher("/adminLogin.jsp").forward(request,response);
        }
    }
}
