package objects;

public class ScheduledCut
{
    Class classToSchedule;
    TimeSlot classTimeSlot;

    public ScheduledCut(Class classToSchedule, TimeSlot classTimeSlot)
    {
        this.classToSchedule=classToSchedule;
        this.classTimeSlot=classTimeSlot;
    }
}
