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

    public void addTime(int newTime)
    {
        if ((this.minute + newTime) >= 60) {
            this.hour++;
            if (this.hour == 13)
            {
                this.hour = 1;
            }
            this.minute +=  newTime;
        }
        else
        {
            this.minute += newTime;
        }
        if (this.minute == 60)
            this.minute = 00;
    }

    public void subtractTime(int newTime)
    {
        if ((this.minute - newTime) < 0)
        {
            this.hour--;
            this.minute = 60 - newTime ;
            if (this.hour == 0)
            {
                this.hour = 12;
            }
        }
        else
        {
            this.minute -= newTime;
        }
        if (this.minute == 60)
            this.minute = 00;
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
        else if (minute < 10)
            return "0" + String.valueOf(minute);
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

    @Override
    public String toString() {
        return "TimeSlot{" +
                "hour=" + hour +
                ", minute=" + minute +
                ", current=" + current +
                ", emptyUser=" + emptyUser.getName() +
                ", payment='" + payment + '\'' +
                ", paymentValue=" + paymentValue +
                '}';
    }
}