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


@WebServlet(urlPatterns={"/loginAdmin"})
public class LoginAdmin extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminUser adminUser = new AdminUser();
        HttpSession sesh = request.getSession();

        //ServletContext context = request.getServletContext();
        if (adminUser.checkValid(request.getParameter("name"), request.getParameter("password")))
        {
            sesh.setAttribute("adminUser", adminUser);
        }
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

}
