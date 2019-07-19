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
import java.sql.Time;


@WebServlet(urlPatterns={"/checkout"})
public class Checkout extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = request.getServletContext();
        TimeSlot ts = (TimeSlot) context.getAttribute("currentTimeSlot");

        ts.setPayment(request.getParameter("paymentType"));
        ts.setPaymentValue(Integer.valueOf(request.getParameter("paymentValue")));

        //ts = (TimeSlot) context.getAttribute("currentTimeSlot");
        context.setAttribute("currentTimeSlot", ts);
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

}
