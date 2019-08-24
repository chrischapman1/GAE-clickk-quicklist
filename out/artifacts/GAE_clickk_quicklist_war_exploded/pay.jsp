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
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="/css/style.css">
    <link href='https://fonts.googleapis.com/css?family=Orbitron' rel='stylesheet' type='text/css'>
</head>
<body>
    <%
        ServletContext context = request.getServletContext();
        TimeSlot ts = (TimeSlot) context.getAttribute("currentTimeSlot");
    %>

    <jsp:include page="/adminMenu.jsp" />

    <h1 class="text-center margin-top-40 margin-bottom-40">Make Payment</h1>

    <div class="container">
        <div class="row justify-content-center">
            <form id="checkout-form" action="checkout" method="post">
                <div class="form-group">
                    <label for="nameInput">Client Name</label>
                    <% if (request.getParameter("nameParameter") != null) { %>
                        <input type="text" class="form-control" id="nameInput" name="nameInput" placeholder="Enter name...">
                    <% } else { %>
                        <input type="text" class="form-control" id="nameInput" name="nameInput" value="<%= ts.getUser().getName()%>" placeholder="Enter name..." readonly>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="appointmentType">Appointment Type</label>
                    <select class="form-control" id="appointmentType" name="appointmentType" onclick="setCost()" required>
                        <option value="" selected disabled hidden>--</option>
                        <option value="mensHaircut">Men's Haircut</option>
                        <option value="mensBuzzcut">Men's Buzzcut</option>
                        <option value="mensFade">Men's Fade</option>
                        <option value="ladiesHaircut">Lady's Haircut</option>
                        <option value="boysCut">Boy's Cut</option>
                        <option value="girlsCut">Girl's Cut</option>
                        <option value="pensionCut">Pension Cut</option>
                    </select>
                </div>
                <div id="shave-div" class="form-group hide">
                    <div class="form-group">
                        <p class="shave-title">Did client also receive a shave?</p>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="shaven-radio" name="shave" value="shaved" onclick="addShave()">
                        <label class="form-check-label" for="shaven-radio">Yes</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="unshaven-radio" name="shave" value="notShaved" onclick="addShave()" checked>
                        <label class="form-check-label" for="unshaven-radio">No</label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="paymentType">Payment Type</label>
                    <select class="form-control" id="paymentType" name="paymentType" onclick="checkFree()" required>
                        <option value="" selected disabled hidden>--</option>
                        <option value="card">Card</option>
                        <option value="cash">Cash</option>
                        <option value="giftVoucher">Gift Voucher</option>
                        <option value="free">Free</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="payment-value">Modify Total $</label>
                    <input id="payment-value" type="number" value="0.00" step="0.01" name="paymentValue" class="form-control">
                </div>
                <div class="form-group">
                    <input type="submit" name="Checkout" value="Checkout" class="btn btn-danger width-100">
                </div>
            </form>
        </div>
    </div>
    <script src="/js/scripts.js"></script>
</body>
</html>
