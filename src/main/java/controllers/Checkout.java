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
        ServletContext context = request.getServletContext();
        TimeSlot ts = (TimeSlot) context.getAttribute("currentTimeSlot");
        ts.setPayment(request.getParameter("paymentType"));
        ts.setPaymentValue(Float.valueOf(request.getParameter("paymentValue")));

        Cart cart = (Cart) context.getAttribute("cart");

        SimpleDateFormat format = new SimpleDateFormat("YYYY MM DD");

        long millis = System.currentTimeMillis();
        Date currentDate = new Date(millis);

        String date = currentDate.toString() +" " +ts.getSQLFormat() +":00";
        boolean success = MySQLConnection.addPayment(date, ts.getUser().getName(), cart.getItem(request.getParameter("appointmentType")).getName(),
                ts.getPayment(), ts.getPaymentValue());

        context.setAttribute("currentTimeSlot", ts);
        context.setAttribute("cart", new Cart());
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

}
