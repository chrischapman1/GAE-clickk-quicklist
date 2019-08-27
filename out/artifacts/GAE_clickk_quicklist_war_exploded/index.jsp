<%@ page import="objects.Day" %>
<%@ page import="objects.AdminUser" %>
<%@ page import="objects.TimeSlot" %>
<%@ page import="java.time.LocalTime" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //prevents caching at the proxy server
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0);
%>

<html>
<head>
  <title>Quicklist</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link type="text/css" rel="stylesheet" href="/css/style.css">
  <link href='https://fonts.googleapis.com/css?family=Orbitron' rel='stylesheet' type='text/css'>
</head>
<body class="welcome">
<%
    ServletContext context = request.getServletContext();
    Day day = (Day) context.getAttribute("day");
    HttpSession sesh = request.getSession();
    AdminUser adminUser = (AdminUser) sesh.getAttribute("adminUser");
    TimeSlot[] timeSlotsClient = day.getTimeSlots(false);
    TimeSlot[] timeSlotsUser = day.getTimeSlots(false);

    LocalTime time = LocalTime.now();
    int hour = time.getHour();
    int min = time.getMinute();

    // For GAE server - time is UTC+0 (need to add 10 hours)
    //hour += 10;
%>

<div class="container-fluid">
    <div class="row justify-content-center background-black">
        <h1 class="font-theme font-white">Welcome to the <span class="highlight-red">Quicklist</span></h1>
    </div>

    <div class="row justify-content-center">
        <h2 class="font-theme">Next approximate time...</h2>
    </div>
    <div class="row justify-content-center">
        <h2 class="font-theme-no-margin highlight-red margin-bottom-40"><%= day.getNextAvailableTime() %></h2>
    </div>
    <div class="row justify-content-center margin-bottom-20">
        <form method="post" action="addUser" class="form-inline">
            <div class="margin-right-10">
                <label class="sr-only" for="inlineFormInputName">Name</label>
                <input type="text" name="name" class="form-control" id="inlineFormInputName" placeholder="Enter name..." required>
            </div>
            <button type="submit" class="btn btn-danger">Join Queue</button>
        </form>
    </div>
    <div class="row">
        <table id="ts">
            <tr>
                <th>Time</th>
                <th>Name</th>
            </tr>
        </table>
    </div>
</div>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
    function refreshTable() {
        (function () {
            // var timeSlotsJson = "https://clickk-quicklist.appspot.com/currentTimeSlot";
            var timeSlotsJson = "http://localhost:8080/currentTimeSlot";
            $.getJSON(timeSlotsJson)
                .done(function (response) {

                    var timeslots = response["timeslots"];
                    // Variables for current time
                    var today = new Date();
                    var hour = today.getHours();
                    var min = today.getMinutes();
                    var amPm = "am";
                    var startIndex = 0;
                    for (var i = 0; i < timeslots.length; i++) {
                        var tsTime = timeslots[i]["time"].split(":");
                        var tsHour = parseInt(tsTime[0], 10);
                        var tsMin = parseInt(tsTime[1], 10);

                        if (tsTime[0] <= 5) {
                            tsTime[0] += 12;
                            amPm = "pm"
                        }

                        if (hour < tsHour || (hour == tsHour && min < tsMin)) {
                            break;
                        } else {
                            startIndex += 1;
                        }
                    }

                    document.getElementById("span-available").textContent = timeslots[startIndex]["time"] +" " +amPm;
                });
        })();
    }

    function createTable() {
        (function () {
            // var timeSlotsJson = "https://clickk-quicklist.appspot.com/currentTimeSlot";
            var timeSlotsJson = "http://localhost:8080/currentTimeSlot";
            $.getJSON(timeSlotsJson)
                .done(function (response) {

                    var timeslots = response["timeslots"];
                    // Variables for current time
                    var today = new Date();
                    var hour = today.getHours();
                    var min = today.getMinutes();
                    var amPm = "am";
                    var startIndex = 0;
                    for (var i = 0; i < timeslots.length; i++) {
                        var tsTime = timeslots[i]["time"].split(":");
                        var tsHour = parseInt(tsTime[0], 10);
                        var tsMin = parseInt(tsTime[1], 10);

                        if (tsTime[0] <= 5) {
                            tsTime[0] += 12;
                            amPm = "pm"
                        }

                        if (hour < tsHour || (hour == tsHour && min < tsMin)) {
                            break;
                        } else {
                            startIndex += 1;
                        }
                    }

                    for (var i=startIndex; i < timeslots.length; i++) {
                        if (timeslots[i]["name"] != "") {
                            var insert = "<tr>"
                                +"<td class=\"time\">"
                                + timeslots[i]["time"]
                                +"</td>"
                                +"<td class=\"name\">"
                                + timeslots[i]["name"]
                                +"</td>"
                                +"</tr>";
                            $('#ts tr:last').after(insert);
                        }
                    }

                    document.getElementById("span-available").textContent = timeslots[startIndex]["time"] +" " +amPm;
                });
        })();
    }

    $(document).ready(function() {
        createTable();
        setInterval(function () {
            refreshTable();
        }, 5000);
    });
</script>

</body>
</html>

