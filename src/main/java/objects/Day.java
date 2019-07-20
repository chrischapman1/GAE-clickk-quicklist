package objects;

import java.util.Calendar;
import java.util.LinkedList;

public class Day {

    private TimeSlot[] timeSlots;

    public TimeSlot[] getTimeSlots() {
        return timeSlots;
    }

    public void setTimeSlots(TimeSlot[] timeSlots) {
        this.timeSlots = timeSlots;
    }

    public Day()
    {

    }

    public void initialise()
    {
        Calendar calendar = Calendar.getInstance();
        int day = calendar.get(Calendar.DAY_OF_WEEK);

         switch (day) {
         /**case Calendar.SUNDAY:
         // Current day is Sunday
         timeSlots = new TimeSlot[0];
         break;
         case Calendar.SATURDAY:
            timeSlots = new TimeSlot[20];
         break;*/

         default:
             assignWeekday();
         }
    }

    public void assignWeekday()
    {
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

        timeSlots[16] = new TimeSlot(1, 0);
        timeSlots[17] = new TimeSlot(1, 15);
        timeSlots[18] = new TimeSlot(1, 30);
        timeSlots[19] = new TimeSlot(1, 45);

        timeSlots[20] = new TimeSlot(2, 0);
        timeSlots[21] = new TimeSlot(2, 15);
        timeSlots[22] = new TimeSlot(2, 30);
        timeSlots[23] = new TimeSlot(2, 45);

        timeSlots[24] = new TimeSlot(3, 0);
        timeSlots[25] = new TimeSlot(3, 15);
        timeSlots[26] = new TimeSlot(3, 30);
        timeSlots[27] = new TimeSlot(3, 45);

        timeSlots[28] = new TimeSlot(4, 0);
        timeSlots[29] = new TimeSlot(4, 15);
        timeSlots[30] = new TimeSlot(4, 30);
        timeSlots[31] = new TimeSlot(4, 45);
    }
}