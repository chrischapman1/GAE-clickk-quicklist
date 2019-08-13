package json;

import objects.Day;
import objects.TimeSlot;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;


@WebServlet(urlPatterns={"/currentTimeSlot"})
public class CurrentTimeSlot extends HttpServlet{

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)  {
        ServletContext context = request.getServletContext();
        Day day = (Day) context.getAttribute("day");
        PrintWriter out = null;
        try {
            out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(getJsonDay(day.getTimeSlots(false)));
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private String getJsonDay(TimeSlot[] timeSlots)
    {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"timeslots\":[");
        for (int k =0; k < timeSlots.length; k++)
        {
            sb.append(TimeSlot.getJsonTimeSlot(timeSlots[k]));
            sb.append(",");
        }
        sb.deleteCharAt(sb.lastIndexOf(","));
        sb.append("]}");
        // DEBUGGING - print JSON string
        //System.out.print(sb.toString());
        return sb.toString();
    }

}
