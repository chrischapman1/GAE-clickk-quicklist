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
    <h1 class="text-center"> Pay for user <%= ts.getUser().getName()%></h1>

    <div class="container">
        <div class="row">
            <!--<form action="addToCart" method="post" class="cartItem" id="appointment-type">-->
            <form class="cartItem" onclick="setCost()">
                Men's Haircut
                <input type="radio" value="mensHaircut" name="cutType">
                <br>
                Men's Buzzcut
                <input type="radio" value="mensBuzzcut" name="cutType">
                <br>
                Men's Fade
                <input type="radio" value="mensFade" name="cutType">
                <br>
                <!-- SEPARATE; and only give option if haircut type is MEN's
                Men's Beard
                <input type="radio" value="mensBeard" name="cutType">
                <br>
                -->
                Ladies Haircut
                <input type="radio" value="ladiesHaircut" name="cutType">
                <br>
                Boy's Cut
                <input type="radio" value="boysCut" name="cutType">
                <br>
                Girl's Cut
                <input type="radio" value="girlsCut" name="cutType">
                <br>
                Pension Cut
                <input type="radio" value="pensionCut" name="cutType">
                <input type="hidden" name="i" value="2">
            </form>

            <script>
                function setCost() {
                    var appType = getAppointmentType();
                    document.getElementById("payment-value").value = getAppointmentCost(appType);

                    // Update hidden field
                    document.getElementById("appointment-type").value = appType;

                    // **ADD**
                    // Add additional field if men's haircut
                    //var element = document.getElementById('shave-form');
                    //if (appType.match("\bmens")) {
                    // if (1 == 1) {
                    //     element.classList.remove('hide');
                    // }
                    // else {
                    //     if (!element.classList.contains('hide'))
                    //         element.classList.add('hide');
                    // }
                }

                // Only required if no submit button is used
                function getAppointmentType() {
                    var options = document.getElementsByName('cutType');
                    for (var i=0; i < options.length; i++) {
                        if (options[i].checked) {
                            return options[i].value;
                        }
                    }
                }

                function getAppointmentCost(type) {
                    switch (type) {
                        case 'mensHaircut': return '28.00';
                        case 'mensBuzzcut': return '20.00';
                        case 'mensFade': return '20.00';
                        //case 'mensBeard': return '18.00';
                        case 'ladiesHaircut': return '28.00';
                        case 'boysCut': return '20.00';
                        case 'girlsCut': return '20.00';
                        case 'pensionCut': return '23.00';
                        default: return '0.00';
                    }
                }
            </script>
        </div>

        <div id="shave-div" class="row">
            <h4>Did client also receive a shave?</h4>
            <form name="shave" onclick="addShave()">
                Yes
                <input type="radio" value="shaved" name="shave">
                No
                <input type="radio" value="notShaved" name="shave">
            </form>
            <script>
                function addShave() {

                }
            </script>
        </div>

        <div class="row">
            <form action="checkout" method="post">
                <select name="paymentType">
                    <option value="card" selected>Card</option>
                    <option value="cash">Cash</option>
                    <option value="giftVoucher">Gift Voucher</option>
                    <option value="free">Free</option>
                </select>
                <br>
                Modify Total
                <input id="payment-value" type="text" value="0.00" name="paymentValue">
                <br>
                <input id="appointment-type" name="appointmentType" type="hidden">
                <input type="submit" name="Checkout" value="Checkout">
            </form>
        </div>
    </div>
</body>
</html>
