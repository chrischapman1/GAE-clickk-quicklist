<%@ page import="objects.TimeSlot" %><%--
  Created by IntelliJ IDEA.
  User: chris
  Date: 8/07/2019
  Time: 7:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pay</title>
</head>
<body>
<%
    ServletContext context = request.getServletContext();
    TimeSlot ts = (TimeSlot) context.getAttribute("currentTimeSlot");
%>
<h1> Pay for user <%= ts.getUser().getName()%></h1>

<form action="checkout" method="post">
    <select name="paymentType">
        <option value="card">Card</option>
        <option value="cash">Cash</option>
        <option value="giftVoucher">Gift Voucher</option>
        <option value="free">Free</option>
    </select>
    <input type="text" value="28" name="paymentValue">
    <input type="submit" name="Submit">
</form>

</body>
</html>
