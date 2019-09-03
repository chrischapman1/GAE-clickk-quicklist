<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="beans.ListBean" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>
<%@ page import="objects.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0);
//prevents caching at the proxy server
%>

<html>
<head>
    <title>Quicklist</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="/css/style.css">
    <link href='https://fonts.googleapis.com/css?family=Orbitron' rel='stylesheet' type='text/css'>
</head>
<body>
    <%
    ServletContext context = request.getServletContext();
    Day day = (Day) context.getAttribute("day");
    DecimalFormat df = new DecimalFormat("0.00");
    double cash = 0.0, card = 0.0, giftvoucher = 0.0, total = 0.0;
    int freeCount = 0;
    for (TimeSlot ts : day.getTimeSlots(false)) {
        if (ts.getFinalPayment() != null) {
            Payment payment = ts.getFinalPayment();
            switch (payment.getPaymentType()) {
                case CARD: card += payment.getAmount(); break;
                case CASH: cash += payment.getAmount(); break;
                case FREE: freeCount++; break;
                case GIFT_VOUCHER: giftvoucher += payment.getAmount(); break;
            }
            total += payment.getAmount();
        }
    }

    String tableOutput =
"           <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css\" integrity=\"sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T\" crossorigin=\"anonymous\">\n" +
"           <table class=\"table table-hover\">\n" +
"                <thead>\n" +
"                <tr>\n" +
"                    <th scope=\"col\">Payment Type</th>\n" +
"                    <th scope=\"col\">Amount</th>\n" +
"                </tr>\n" +
"                </thead>\n" +
"                <tbody>\n" +
"                <tr>\n" +
"                    <td>Card</td>\n" +
"                    <td>$" +df.format(card) +"</td>\n" +
"                </tr>\n" +
"                <tr>\n" +
"                    <td>Cash</td>\n" +
"                    <td>$" +df.format(cash) +"</td>\n" +
"                </tr>\n" +
"                <tr>\n" +
"                    <td>Gift Voucher</td>\n" +
"                    <td>$" +df.format(giftvoucher) +"</td>\n" +
"                </tr>\n" +
"                <tr>\n" +
"                    <td>Free (count)</td>\n" +
"                    <td>" +freeCount +"</td>\n" +
"                </tr>\n" +
"                <tr class=\"table-active\">\n" +
"                    <td>Total</td>\n" +
"                    <td>$" +df.format(total) +"</td>\n" +
"                </tr>\n" +
"                </tbody>\n" +
"            </table>\n";

    day.setHtmlAnalyticsOutput(tableOutput);

    %>

    <jsp:include page="adminMenu.jsp" />

    <div class="container">
        <div class="row justify-content-center">
            <h1 class="font-theme">Close Day</h1>
        </div>
        <div class="row justify-content-center">
            <%= tableOutput %>
        </div>
        <div class="row justify-content-center">
            <form id="email-form-btn" method="post" action="emailDay">
                <input type="submit" name="submit" value="Email Day" class="btn btn-danger">
            </form>
            <form id="close-form-btn" method="post" action="newDay">
                <input type="submit" name="submit" value="Close Day" class="btn btn-danger">
            </form>
        </div>
    </div>

</body>
</html>