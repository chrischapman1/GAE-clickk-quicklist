<%@ page import="objects.TimeSlot" %>
<%@ page import="objects.Cart" %>
<%@ page import="objects.Item" %><%--
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

<form action="addToCart" method="post" class="cartItem">
    Men's Haircut
    <input type="checkbox" value="mensHaircut" name="cutType">
    <br>
    Men's Buzzcut
    <input type="checkbox" value="mensBuzzcut" name="cutType">
    <br>
    Men's Fade
    <input type="checkbox" value="mensFade" name="cutType">
    <br>
    Men's Beard
    <input type="checkbox" value="mensBeard" name="cutType">
    <br>
    Ladies Haircut
    <input type="checkbox" value="ladiesHaircut" name="cutType">
    <br>
    Boy's Cut
    <input type="checkbox" value="boysCut" name="cutType">
    <br>
    Girl's Cut
    <input type="checkbox" value="girlsCut" name="cutType">
    <br>
    Pension Cut
    <input type="checkbox" value="pensionCut" name="cutType">
    <input type="submit" name="Submit">
</form>

<table>
    <th>Item & Price</th>
<%
    Cart c = (Cart) context.getAttribute("cart");
    for (Item i : c.getCart()) {
%>
    <tr> <td> <%= i.toString()%> </td> </tr>
<% } %>
</table>
<h4>Total is $<%=c.getTotal()%></h4>

<form action="checkout" method="post">
    <select name="paymentType">
        <option value="card">Card</option>
        <option value="cash">Cash</option>
        <option value="giftVoucher">Gift Voucher</option>
        <option value="free">Free</option>
    </select>
    Modify Total
    <input type="text" value="<%=c.getTotal()%>" name="paymentValue">
    Checkout
    <input type="submit" name="Submit">
</form>

</body>
</html>
