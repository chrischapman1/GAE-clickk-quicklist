package objects;

import java.text.SimpleDateFormat;
import java.util.*;

public class Day {

    private TimeSlot[] timeSlots;
    private boolean isWeekend;
    public TimeSlot[] getTimeSlots(boolean isClient) {
        if (!(isClient))
        {
            return timeSlots;
        }
        else
        {
            List<TimeSlot> clientTimeSlots = new LinkedList<>();
            for (int i =0; i < timeSlots.length; i++)
            {
                if (!(timeSlots[i].getUser().getName().equals("")))
                {
                    clientTimeSlots.add(timeSlots[i]);
                }
            }
            for (int i =0; i < timeSlots.length; i++)
            {
                if ((timeSlots[i].getUser().getName().equals("")))
                {
                    clientTimeSlots.add(timeSlots[i]);
                    break;
                }
            }
            return clientTimeSlots.toArray(new TimeSlot[clientTimeSlots.size()]);
        }
    }

    public void setTimeSlots(TimeSlot[] timeSlots) {
        this.timeSlots = timeSlots;
    }

    public Day()
    {

    }

    public String getNextAvailableTime()
    {
        SimpleDateFormat format = new SimpleDateFormat("HH");
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
                    return timeSlots[i].getHourMinute();
                }

            }
            //No empty
        }

        return "when we open next (No spots are available today). ";
    }

    public void initialise(boolean isWeekend)
    {
        Calendar calendar = Calendar.getInstance();
        int day = calendar.get(Calendar.DAY_OF_WEEK);

         if (isWeekend) {
            assignWeekend();
         }
         else
         {
             assignWeekday();
         }
    }


    public void assignWeekday()
    {
        isWeekend = false;
        timeSlots = new TimeSlot[32];
        timeSlots[0] = new TimeSlot(9, 0);
        timeSlots[1] = new TimeSlot(9, 15);
        timeSlots[2] = new TimeSlot(9, 30);
        timeSlots[3] = new TimeSlot(9, 45);

        timeSlots[4] = new TimeSlot(10, 0);
        timeSlots[5] = new TimeSlot(10, 15);
        timeSlots[6] = new TimeSlot(10, 30);
        timeSlots[7] = new TimeSlot(10, 45);

        timeSlots[8] = new TimeSlot(11, 0);
        timeSlots[9] = new TimeSlot(11, 15);
        timeSlots[10] = new TimeSlot(11, 30);
        timeSlots[11] = new TimeSlot(11, 45);

        timeSlots[12] = new TimeSlot(12, 0);
        timeSlots[13] = new TimeSlot(12, 15);
        timeSlots[14] = new TimeSlot(12, 30);
        timeSlots[15] = new TimeSlot(12, 45);

        timeSlots[16] = new TimeSlot(13, 0);
        timeSlots[17] = new TimeSlot(13, 15);
        timeSlots[18] = new TimeSlot(13, 30);
        timeSlots[19] = new TimeSlot(13, 45);

        timeSlots[20] = new TimeSlot(14, 0);
        timeSlots[21] = new TimeSlot(14, 15);
        timeSlots[22] = new TimeSlot(14, 30);
        timeSlots[23] = new TimeSlot(14, 45);

        timeSlots[24] = new TimeSlot(15, 0);
        timeSlots[25] = new TimeSlot(15, 15);
        timeSlots[26] = new TimeSlot(15, 30);
        timeSlots[27] = new TimeSlot(15, 45);

        timeSlots[28] = new TimeSlot(16, 0);
        timeSlots[29] = new TimeSlot(16, 15);
        timeSlots[30] = new TimeSlot(16, 30);
        timeSlots[31] = new TimeSlot(16, 45);
    }

    public void assignWeekend()
    {
        isWeekend = true;
        timeSlots = new TimeSlot[19];
        timeSlots[0] = new TimeSlot(8, 0);
        timeSlots[1] = new TimeSlot(8, 15);
        timeSlots[2] = new TimeSlot(8, 30);
        timeSlots[3] = new TimeSlot(8, 45);

        timeSlots[4] = new TimeSlot(9, 0);
        timeSlots[5] = new TimeSlot(9, 15);
        timeSlots[6] = new TimeSlot(9, 30);
        timeSlots[7] = new TimeSlot(9, 45);

        timeSlots[8] = new TimeSlot(10, 0);
        timeSlots[9] = new TimeSlot(10, 15);
        timeSlots[10] = new TimeSlot(10, 30);
        timeSlots[11] = new TimeSlot(10, 45);

        timeSlots[12] = new TimeSlot(11, 0);
        timeSlots[13] = new TimeSlot(11, 15);
        timeSlots[14] = new TimeSlot(11, 30);
        timeSlots[15] = new TimeSlot(11, 45);

        timeSlots[16] = new TimeSlot(12, 0);
        timeSlots[17] = new TimeSlot(12, 15);
        timeSlots[18] = new TimeSlot(12, 30);
        timeSlots[19] = new TimeSlot(12, 45);

    }

    public boolean isWeekend()
    {
        return isWeekend;
    }
}
