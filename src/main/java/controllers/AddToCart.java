package controllers;

import config.MySQLConnection;
import objects.*;
import beans.ListBean;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.text.SimpleDateFormat;


@WebServlet(urlPatterns={"/addToCart"})
public class AddToCart extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = request.getServletContext();
//        Day day = (Day) context.getAttribute("day");
//        TimeSlot ts = day.getTimeSlots()[Integer.valueOf(request.getParameter("i"))];
//        ts = (TimeSlot) context.getAttribute("currentTimeSlot");
//        context.setAttribute("currentTimeSlot", ts);

        Cart cart = (Cart) context.getAttribute("cart");
        cart.addCart(request.getParameter("cutType"));
        context.setAttribute("cart", cart);

        request.getRequestDispatcher("WEB-INF/jsp/pay.jsp").forward(request,response);
    }
}