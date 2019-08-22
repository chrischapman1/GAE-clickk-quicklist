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

<nav class="navbar navbar-dark bg-dark justify-content-between">
    <a class="navbar-brand nav-header">Admin Login</a>
    <form method="post" action="loginAdmin" class="form-inline">
        <input name="name" class="form-control mr-sm-2" type="text" placeholder="Username" aria-label="Search" required>
        <input name="password" class="form-control mr-sm-2" type="password" placeholder="Password" aria-label="Search" required>
        <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">Login</button>
    </form>
</nav>

<h1 class="font-theme">Welcome to the <span class="highlight-red">Quicklist</span></h1>

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
%>

<div class="container">
    <div class="row justify-content-center">
        <h2 class="margin-bottom-20">Next available time slot -  <%= day.getNextAvailableTime() %></h2>
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
</div>

<div class="container">
    <table id="ts">
        <tr>
            <th class="time">Time</th>
            <th class="name">Name</th>
        </tr>
        <% for (int i=0; i < timeSlotsClient.length; i++) { %>
        <% if (hour < timeSlotsClient[i].getHour() || (hour == timeSlotsClient[i].getHour() && min < timeSlotsClient[i].getMinute())) { %>
        <tr>
            <td class="time">
                <%= timeSlotsClient[i].getHour() %> : <%= timeSlotsClient[i].getStringMinute() %>
            </td>
            <td class="name">
                <%= timeSlotsClient[i].getUser().getName() %>
            </td>
        </tr>
        <% } %>
        <% } %>
    </table>
</div>

</body>
</html>

