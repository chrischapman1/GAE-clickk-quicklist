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

    <h1 class="text-center margin-top-40 margin-bottom-20"> Payment - Client: <%= ts.getUser().getName()%></h1>

    <div class="container">
        <div class="row justify-content-center width-100 form-group">
            <!--<form action="addToCart" method="post" class="cartItem" id="appointment-type">-->
            <form onclick="setCost()">
                <label for="appointmentType">Appointment Type</label>
                <select class="form-control" id="appointmentType">
                    <option value="" selected disabled hidden>--</option>
                    <option value="mensHaircut">Men's Haircut</option>
                    <option value="mensBuzzcut">Men's Buzzcut</option>
                    <option value="mensFade">Men's Fade</option>
                    <option value="ladiesHaircut">Lady's Haircut</option>
                    <option value="boysCut">Boy's Cut</option>
                    <option value="girlsCut">Girl's Cut</option>
                    <option value="pensionCut">Pension Cut</option>
                </select>
                <input type="hidden" name="i" value="2">
            </form>

            <script>
                function setCost() {
                    var typeElement = document.getElementById("paymentType");
                    if (typeElement.options[typeElement.selectedIndex].value != "free") {
                        var typeElement = document.getElementById("appointmentType");
                        var appType = typeElement.options[typeElement.selectedIndex].value;
                        document.getElementById("payment-value").value = getAppointmentCost(appType).toFixed(2);

                        // Update hidden field
                        document.getElementById("appointment-type").value = appType;

                        // Give option of adding a shave if man's appointment
                        var element = document.getElementById("shave-div");
                        if (/\bmens/.test(appType)) {
                            if (element.classList.contains("hide")) {
                                element.classList.remove("hide");
                            }
                        } else {
                            if (!element.classList.contains("hide")) {
                                element.classList.add("hide");
                            }
                        }
                    }
                }

                // Get value of radio button given name
                function getRadioValue(name) {
                    var options = document.getElementsByName(name);
                    for (var i=0; i < options.length; i++) {
                        if (options[i].checked) {
                            return options[i].value;
                        }
                    }
                }

                function getAppointmentCost(type) {
                    switch (type) {
                        case 'mensHaircut': return 28.0;
                        case 'mensBuzzcut': return 20.0;
                        case 'mensFade': return 20.0;
                        //case 'mensBeard': return '18.00';
                        case 'ladiesHaircut': return 28.0;
                        case 'boysCut': return 20.0;
                        case 'girlsCut': return 20.0;
                        case 'pensionCut': return 23.0;
                        default: return 0.0;
                    }
                }
            </script>
        </div>

        <div id="shave-div" class="row justify-content-center form-group hide">
            <hr>
            <form onclick="addShave()">
                <div class="form-group">
                    <p class="shave-title">Did client also receive a shave?</p>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="shaven-radio" name="shave" value="shaved">
                    <label class="form-check-label" for="shaven-radio">Yes</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="unshaven-radio" name="shave" value="notShaved" checked>
                    <label class="form-check-label" for="unshaven-radio">No</label>
                </div>
            </form>
            <hr>

            <script>
                function addShave() {
                    var element = document.getElementById("payment-value");
                    var total = parseFloat(element.value);

                    if (getRadioValue("shave") == "shaved") {
                        if (total <= 28.00) {
                            total += 18.0;
                        }
                    } else {
                        if (total >= 38.0) {
                            total -= 18.0;
                        }
                    }

                    element.value = total.toFixed(2);
                }
            </script>
        </div>

        <div class="row justify-content-center">
            <form action="checkout" method="post">
                <div class="form-group">
                    <label for="paymentType">Payment Type</label>
                    <select class="form-control" id="paymentType" onclick="checkFree()">
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
                <div class="form-group justify-content-center">
                    <input id="appointment-type" name="appointmentType" type="hidden">
                    <input type="submit" name="Checkout" value="Checkout" class="btn btn-danger width-100">
                </div>
            </form>

            <script>
                function checkFree() {
                    var paymentElement = document.getElementById("payment-value");
                    var payment = parseFloat(paymentElement.value);

                    var typeElement = document.getElementById("paymentType");
                    if (typeElement.options[typeElement.selectedIndex].value == "free") {
                        payment = 0.0;
                        paymentElement.value = payment.toFixed(2);
                    } else {
                        if (payment == 0.0) {
                            var typeElement = document.getElementById("appointmentType");
                            var appType = typeElement.options[typeElement.selectedIndex].value;
                            payment = getAppointmentCost(appType);
                            paymentElement.value = payment.toFixed(2);

                            // Check for shave
                            if (/\bmens/.test(appType)) {
                                addShave();
                            }
                        }
                    }
                }
            </script>
        </div>
    </div>
</body>
</html>
