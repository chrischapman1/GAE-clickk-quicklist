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
        // Validate admin user server side
        ServletContext context = request.getServletContext();
        if (context.getAttribute("adminUser") != null) {
            boolean isWeekend = Boolean.valueOf(request.getParameter("isWeekend"));
            Day day = new Day(isWeekend);
            context.setAttribute("day", day);
            context.setAttribute("isClosed", true);
            request.getRequestDispatcher("WEB-INF/jsp/adminView.jsp").forward(request,response);
        } else {
            request.getRequestDispatcher("WEB-INF/jsp/adminLogin.jsp").forward(request,response);
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate admin user server side
        ServletContext context = request.getServletContext();
        if (context.getAttribute("adminUser") != null) {
            Day day = new Day(false);
            context.setAttribute("day", day);
            context.setAttribute("isClosed", false);
            request.getRequestDispatcher("WEB-INF/jsp/adminView.jsp").forward(request,response);
        } else {
            request.getRequestDispatcher("WEB-INF/jsp/adminLogin.jsp").forward(request,response);
        }
    }
}
