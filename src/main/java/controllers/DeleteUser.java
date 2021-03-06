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


@WebServlet(urlPatterns={"/deleteUser"})
public class DeleteUser extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate admin user server side
        ServletContext context = request.getServletContext();
        if (context.getAttribute("adminUser") != null) {
            Day day = (Day) context.getAttribute("day");
            int i = Integer.valueOf(request.getParameter("i"));

            TimeSlot[] timeSlots = day.getTimeSlots(false);
            TimeSlot current = new TimeSlot(timeSlots[i].getHour(), timeSlots[i].getMinute());
            timeSlots[i] = current;
            day.setTimeSlots(timeSlots);
            context.setAttribute("day", day);
            request.getRequestDispatcher("WEB-INF/jsp/adminView.jsp").forward(request,response);
        } else {
            request.getRequestDispatcher("WEB-INF/jsp/adminLogin.jsp").forward(request,response);
        }
    }
}
