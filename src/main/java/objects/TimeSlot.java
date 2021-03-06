package objects;

import java.util.Calendar;

public class TimeSlot
{
    private int hour;  //Holds the day and the hour for the start
    private int minute;    //Holds the day and the hour for the end
    private User current;
    private User emptyUser;

    private String payment = "";
    private float paymentValue = 0;

    private Payment finalPayment;

    public TimeSlot()
    {
    }

    public TimeSlot(int hour, int minute)
    {
        this.hour = hour;
        this.minute = minute;
        emptyUser = new User("","");
        this.current = emptyUser;

        this.finalPayment = null;
    }

    public static String getJsonTimeSlot(TimeSlot ts)
    {
        return "{ \"time\":\"" + ts.getHourMinute() + "\",\"name\":\""
                + ts.getUser().getName() + "\",\"details\":\"" + ts.getUser().getPhoneemail() + "\"}";
//        return "{ \"time\":\"" + ts.getSQLFormat() + "\",\"name\":\""
//                + ts.getUser().getName() + "\",\"details\":\"" + ts.getUser().getPhoneemail() + "\"}";
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

    public int getDisplayHour() {
        if (hour == 12)
        {
            return 12;
        }
        else
        {
            return hour % 12;
        }
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
        if (this.hour < 12)
            return getDisplayHour() + ":" + getStringMinute();
        else
            return getDisplayHour() + ":" + getStringMinute();
    }

    public String getTimeAMPM()
    {
        if (this.hour < 12)
            return getDisplayHour() + ":" + getStringMinute() +" am";
        else
            return getDisplayHour() + ":" + getStringMinute() +" pm";
    }

    public float getPaymentValue() {
        return paymentValue;
    }

    public String getPaymentDollar() {
        return String.format("%.2f", this.paymentValue);
    }

    public void setPaymentValue(float paymentValue) {
        this.paymentValue = paymentValue;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        switch (payment) {
            case "card":        this.payment = "Card";          break;
            case "cash":        this.payment = "Cash";          break;
            case "giftVoucher": this.payment = "Gift Voucher";  break;
            case "free":        this.payment = "Free";          break;
            default:            this.payment = "Other";         break;
        }
    }

    public String getSQLFormat() {
        if (this.hour < 10)
            return "0" +this.hour + ":" + getStringMinute();
        else
            return this.hour + ":" + getStringMinute();
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

    public Payment getFinalPayment() {
        return finalPayment;
    }

    public void setFinalPayment(String appointmentType, double amount, String payment) {
        this.finalPayment = new Payment(appointmentType, amount, getPaymentType(payment));
    }

    private Payment.PaymentType getPaymentType(String paymentType) {
        switch (paymentType) {
            case "cash": return Payment.PaymentType.CASH;
            case "giftVoucher": return Payment.PaymentType.GIFT_VOUCHER;
            case "free": return Payment.PaymentType.FREE;
            default: return Payment.PaymentType.CARD;
        }
    }
}