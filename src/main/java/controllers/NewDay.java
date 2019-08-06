package controllers;

import com.sun.xml.internal.messaging.saaj.packaging.mime.MessagingException;
import objects.AdminUser;
import objects.Day;
import objects.TimeSlot;
import objects.User;
import beans.ListBean;
import org.apache.catalina.Session;
import sun.plugin2.message.Message;
import sun.plugin2.message.transport.Transport;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.Properties;


@WebServlet(urlPatterns={"/newDay"})
public class NewDay extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = request.getServletContext();
        Day day = new Day();
        boolean isWeekend = Boolean.valueOf(request.getParameter("isWeekend"));
        day.initialise(isWeekend);
        context.setAttribute("day", day);
        boolean isClosed = true;
        context.setAttribute("isClosed", isClosed);
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }
}
