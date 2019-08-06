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


@WebServlet(urlPatterns={"/logoutAdmin"})
public class LogoutAdmin extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesh = request.getSession();
        sesh.setAttribute("adminUser", null);
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

}
