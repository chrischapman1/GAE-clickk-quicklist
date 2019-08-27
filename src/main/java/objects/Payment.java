package objects;

public class Payment {
    enum PaymentType {
        CARD,
        CASH,
        GIFT_VOUCHER,
        FREE
    }

    private String appointmentType;
    private double amount;
    private PaymentType paymentType;

    public Payment(String appointmentType, double amount, PaymentType paymentType) {
        this.appointmentType = appointmentType;
        this.amount = amount;
        this.paymentType = paymentType;
    }

    public String getAppointmentType() {
        return appointmentType;
    }

    public void setAppointmentType(String appointmentType) {
        this.appointmentType = appointmentType;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public PaymentType getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
    }
}
