<%@ page import="java.util.LinkedList" %>
<%@ page import="objects.User" %>
<%@ page import="java.util.List" %>
<%@ page import="beans.ListBean" %>
<%@ page import="objects.Day" %>
<%@ page import="objects.TimeSlot" %>
<%@ page import="objects.AdminUser" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>
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
<h1>Close Day</h1>

    <%
    ServletContext context = request.getServletContext();
    Day day = (Day) context.getAttribute("day");
    TimeSlot[] current = day.getTimeSlots(false);
    int cash = 0, card = 0, giftvoucher = 0, free = 0;
    for (int i=0; i < current.length; i++)
    {
        if (current[i].getPayment().equals("cash"))
            cash += current[i].getPaymentValue();
        else if (current[i].getPayment().equals("card"))
            card += current[i].getPaymentValue();
        else if (current[i].getPayment().equals("giftVoucher"))
            giftvoucher += current[i].getPaymentValue();
        else if (current[i].getPayment().equals("free"))
            free += current[i].getPaymentValue();
    }
    String takings = "Card: " + card + "Cash: " + cash + "Gift Voucher: " + giftvoucher + "Free: " + free;
    context.setAttribute("dayTakings", takings);
    %>
    Card: $<%=card%> <br>
    Cash: $<%=cash%> <br>
    Gift Voucher: $<%=giftvoucher%> <br>
    Free: $<%=free%>


    <form method="post" action="emailDay">
        <input type="submit" name="submit" value="Email Day"></input>
    </form>

    <form method="post" action="newDay">
        <input type="submit" name="submit" value="Close Day"></input>
    </form>
</body>
</html>