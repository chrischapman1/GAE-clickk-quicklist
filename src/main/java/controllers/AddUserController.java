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


@WebServlet(urlPatterns={"/addUser"})
public class AddUserController extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User current = new User(request.getParameter("name"), request.getParameter("phoneemail"));

        ServletContext context = request.getServletContext();
        Day day = (Day) context.getAttribute("day");
        TimeSlot[] timeSlots = day.getTimeSlots();
        for(int i=0; i < timeSlots.length ; i++) {
            if (timeSlots[i].getUser().getName().equals(""))
            {
                timeSlots[i].addUser(current);
                break;
            }
        }

        context.setAttribute("day", day);
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

}
