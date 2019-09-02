package controllers;

import config.MySQLConnection;
import objects.*;
import beans.ListBean;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;


@WebServlet(urlPatterns={"/checkout"})
public class Checkout extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate admin user server side
        ServletContext context = request.getServletContext();
        if (context.getAttribute("adminUser") != null) {
            TimeSlot ts = (TimeSlot) context.getAttribute("currentTimeSlot");

            ts.setPayment(request.getParameter("paymentType"));
            ts.setPaymentValue(Float.parseFloat(request.getParameter("paymentValue")));

            Cart cart = (Cart) context.getAttribute("cart");

            SimpleDateFormat format = new SimpleDateFormat("YYYY MM DD");

            long millis = System.currentTimeMillis();
            Date currentDate = new Date(millis);

            boolean shaved = request.getParameter("shave").equals("shaved");
            String appointmentType = cart.getItem(request.getParameter("appointmentType")).getName();
            if (shaved)
                appointmentType += " + Shave";

            String date = currentDate.toString() +" " +ts.getSQLFormat() +":00";
//        boolean success = MySQLConnection.addPayment(date, request.getParameter("nameInput"), appointmentType,
//                ts.getPayment(), ts.getPaymentValue());

            ts.setFinalPayment(appointmentType, Float.parseFloat(request.getParameter("paymentValue")),
                    request.getParameter("paymentType"));

            context.setAttribute("currentTimeSlot", ts);
            context.setAttribute("cart", new Cart());
            request.getRequestDispatcher("/adminView.jsp").forward(request,response);
        } else {
            request.getRequestDispatcher("/adminLogin.jsp").forward(request,response);
        }
    }
}
