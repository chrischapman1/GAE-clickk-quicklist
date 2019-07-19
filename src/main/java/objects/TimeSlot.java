package objects;

import java.util.Calendar;

public class TimeSlot
{
    private int hour;  //Holds the day and the hour for the start
    private int minute;    //Holds the day and the hour for the end
    private User current;
    private User emptyUser;

    private String payment = "";
    int paymentValue = 0;

    public TimeSlot(int hour, int minute)
    {
        this.hour = hour;
        this.minute = minute;
        emptyUser = new User("","");
        this.current = emptyUser;
    }

    public static String getJsonTimeSlot(TimeSlot ts)
    {
        return "{ \"time\":\"" + ts.getHourMinute() + "\",\"name\":\""
                + ts.getUser().getName() + "\",\"details\":\"" + ts.getUser().getPhoneemail() + "\"}";
    }

    public boolean fulfilled()
    {
        return (current == null);
    }

    public void addUser(User input)
    {
        this.current = input;
    }

    public User getUser()
    {
        return current;
    }

    public int getHour() {
        return hour;
    }

    public int getMinute() {
        return minute;
    }

    public String getStringMinute() {
        if (minute == 0)
            return "00";
        else
            return String.valueOf(minute);
    }

    public String getHourMinute()
    {
        return hour + ":" + getStringMinute();
    }

    public int getPaymentValue() {
        return paymentValue;
    }

    public void setPaymentValue(int paymentValue) {
        this.paymentValue = paymentValue;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }
}