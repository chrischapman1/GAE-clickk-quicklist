package controllers;

import objects.Day;
import objects.TimeSlot;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;


@WebServlet(urlPatterns={"/modifyTime"})
public class ModifyTime extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {// Validate admin user server side
        ServletContext context = request.getServletContext();
        if (context.getAttribute("adminUser") != null) {
            Day day = (Day) context.getAttribute("day");
            TimeSlot[] timeSlots = day.getTimeSlots(false);
            int timePeriod = Integer.valueOf(request.getParameter("timeValue"));
            boolean isAdd = request.getParameter("modifyType").equals("add");

            if (isAdd)
            {
                System.out.print(request.getParameter("timePeriod") + request.getParameter("isAdd"));
                for(int i=0; i < timeSlots.length ; i++){
                    timeSlots[i].addTime(timePeriod);
                    System.out.print(timeSlots[i].toString());
                }
            }
            else
            {
                for(int i=0; i < timeSlots.length ; i++){
                    timeSlots[i].subtractTime(timePeriod);
                }
            }

            context.setAttribute("day", day);
            request.getRequestDispatcher("/adminView.jsp").forward(request,response);
        } else {
            request.getRequestDispatcher("/adminLogin.jsp").forward(request,response);
        }
    }

}
