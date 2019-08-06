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
        ServletContext context = request.getServletContext();
        Day day = new Day();
        boolean isWeekend = Boolean.valueOf(request.getParameter("isWeekend"));
        day.initialise(isWeekend);
        context.setAttribute("day", day);
        boolean isClosed = false;
        context.setAttribute("isClosed", isClosed);
        HttpSession sesh = request.getSession();
        sesh.invalidate();
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

}
