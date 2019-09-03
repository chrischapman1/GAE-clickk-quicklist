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


@WebServlet(urlPatterns={"/pay"})
public class Pay extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate admin user server side
        ServletContext context = request.getServletContext();
        if (context.getAttribute("adminUser") != null) {
            Day day = (Day) context.getAttribute("day");
            TimeSlot ts = new TimeSlot();

            int i = Integer.valueOf(request.getParameter("i"));
            if (i == -1)
            {
                ts = new TimeSlot(-1, 00);
            }
            else
            {
                ts = day.getTimeSlots(false)[i];
            }

            //ts = (TimeSlot) context.getAttribute("currentTimeSlot");
            context.setAttribute("currentTimeSlot", ts);
            request.getRequestDispatcher("WEB-INF/jsp/pay.jsp").forward(request,response);
        } else {
            request.getRequestDispatcher("WEB-INF/jsp/adminLogin.jsp").forward(request,response);
        }
    }
}
