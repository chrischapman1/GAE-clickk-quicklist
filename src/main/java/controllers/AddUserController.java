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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;


@WebServlet(urlPatterns={"/addUser"})
public class AddUserController extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User current = new User(request.getParameter("name"), request.getParameter("phoneemail"));

        ServletContext context = request.getServletContext();
        Day day = (Day) context.getAttribute("day");
        TimeSlot[] timeSlots = day.getTimeSlots(false);

        // Time should be expressed in 24-hour time; to enable logic for booking
        // ---------------------------------------------------------------------
        SimpleDateFormat format = new SimpleDateFormat("HH");
        // ---------------------------------------------------------------------

        format.setTimeZone(TimeZone.getTimeZone("Australia/NSW"));
        String formattedDate = format.format(new Date());
        int hour  = Integer.parseInt(formattedDate);

        SimpleDateFormat formatMin = new SimpleDateFormat("mm");
        formatMin.setTimeZone(TimeZone.getTimeZone("Australia/NSW"));
        String formattedDateMin = formatMin.format(new Date());
        int min  = Integer.parseInt(formattedDateMin);

        for (int i =0; i < timeSlots.length; i++)
        {
            if (timeSlots[i].getUser().getName().equals(""))
            {
                if ((hour < timeSlots[i].getHour()) || ((hour == timeSlots[i].getHour()) && (min < timeSlots[i].getMinute()))) {
                    timeSlots[i].addUser(current);
                    // ---------------------------------------------------------------------
                    break;
                    // ---------------------------------------------------------------------
                }
            }
            //No empty
        }

        context.setAttribute("day", day);
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) {
    }

}
