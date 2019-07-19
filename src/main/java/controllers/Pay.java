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
        ServletContext context = request.getServletContext();
        Day day = (Day) context.getAttribute("day");
        TimeSlot ts = day.getTimeSlots()[Integer.valueOf(request.getParameter("i"))];
        //ts = (TimeSlot) context.getAttribute("currentTimeSlot");
        context.setAttribute("currentTimeSlot", ts);
        request.getRequestDispatcher("/pay.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

}
