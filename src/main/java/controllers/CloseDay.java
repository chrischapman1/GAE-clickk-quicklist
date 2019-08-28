package controllers;

import objects.*;
import beans.ListBean;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;


@WebServlet(urlPatterns={"/closeDay"})
public class CloseDay extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = request.getServletContext();
        Day day = (Day) context.getAttribute("day");

        for (TimeSlot ts : day.getTimeSlots(false)) {
            Payment payment = ts.getFinalPayment();
            if (payment != null)
                System.out.println(ts.getSQLFormat() +": " +ts.getFinalPayment().toString());
            else
                System.out.println(ts.getSQLFormat() +": no payment made");
        }

        request.getRequestDispatcher("/closeDay.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

}
