<%@ page import="objects.Day" %>
<%@ page import="objects.AdminUser" %>
<%@ page import="objects.TimeSlot" %><%--
  Created by IntelliJ IDEA.
  User: dylan
  Date: 20/08/2019
  Time: 11:12 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //prevents caching at the proxy server
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0);
%>
<html>
<head>
    <title>Admin</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="/css/style.css">
    <link href='https://fonts.googleapis.com/css?family=Orbitron' rel='stylesheet' type='text/css'>
</head>
<body>

<%
    ServletContext context = request.getServletContext();
    Day day = (Day) context.getAttribute("day");
    HttpSession sesh = request.getSession();
    AdminUser adminUser = (AdminUser) sesh.getAttribute("adminUser");
    TimeSlot[] timeSlotsClient = day.getTimeSlots(false);
    TimeSlot[] timeSlotsUser = day.getTimeSlots(false);
%>

<jsp:include page="/adminMenu.jsp" />

<h1 class="font-theme">Quicklist Admin</h1>

<div class="container">
    <div class="row justify-content-center">
        <form method="get" action="/closeDay">
            <input type="submit" value="Close Day" class="btn btn-danger" />
        </form>
    </div>
    <div>
        <table id="ts">
            <tr>
                <th>Time</th>
                <th>Name</th>
                <th>Options</th>
            </tr>

            <% for (int i=0; i < timeSlotsClient.length; i++) { %>
            <tr>
                <td class="time">
                    <%= timeSlotsClient[i].getDisplayHour() %>:<%= timeSlotsClient[i].getStringMinute() %>
                </td>
                <td class="name">
                    <%= timeSlotsClient[i].getUser().getName() %>
                </td>
                <td>
                    <%
                        if (!timeSlotsUser[i].getUser().getName().equals("")) {
                            if (timeSlotsUser[i].getPaymentValue() != 0) {
                    %>
                    <p class="name">
                        Paid by <%=timeSlotsUser[i].getPayment()%> for $<%=timeSlotsUser[i].getPaymentDollar()%>
                    </p>
                    <%      } else { %>
                    <div class="container option-div">
                        <div class="row">
                            <div class="col">
                                <form method="post" action="pay" class="no-margin-form">
                                    <input type="text" value="<%=i%>" name="i" hidden="true"></input>
                                    <input type="submit" name="submit" value="Pay" class="btn btn-success float-right btn-width-100"></input>
                                </form>
                            </div>
                            <div class="col">
                                <form method="post" action="deleteUser" class="no-margin-form">
                                    <input type="text" value="<%=i%>" name="i" hidden="true"></input>
                                    <input type="submit" name="submit" value="Delete" class="btn btn-danger float-left btn-width-100"></input>
                                </form>
                            </div>
                        </div>
                    </div>
                    <%      }} %>
                </td>
            </tr>
            <% } %>
        </table>
    </div>

</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
    function refreshTable()
    {
        (function() {
            // var timeSlotsJson = "https://clickk-quicklist.appspot.com/currentTimeSlot";
            var timeSlotsJson = "http://localhost:8080/currentTimeSlot";
            $.getJSON(timeSlotsJson)
                .done(function (response) {
                    var timeslots = response["timeslots"];

                    for (i = 0; i < timeslots.length; i++) {
                        document.getElementById("ts").rows[i + 1].cells[0].innerHTML = (timeslots[i]["time"]);
                        document.getElementById("ts").rows[i + 1].cells[1].innerHTML = (timeslots[i]["name"]);
                    }
                });
        })();
    }

    $(document).ready(function() {
        setInterval(function () {
            refreshTable();
        }, 5000);
    });
</script>

</body>
</html>