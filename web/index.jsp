<%@ page import="objects.User" %>
<%@ page import="beans.ListBean" %>
<%@ page import="objects.Day" %>
<%@ page import="objects.TimeSlot" %>
<%@ page import="objects.AdminUser" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>
<%@ page import="javax.xml.bind.Marshaller" %>
<%@ page import="java.time.Clock" %>
<%@ page import="java.util.*" %>
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
<body class="home">

<div class="welcome">
<h1>Welcome to the Quicklist</h1>

<%
  ServletContext context = request.getServletContext();
  Day day = (Day) context.getAttribute("day");
  HttpSession sesh = request.getSession();
  AdminUser adminUser = (AdminUser) sesh.getAttribute("adminUser");
  TimeSlot[] timeSlotsClient = day.getTimeSlots(false);
  TimeSlot[] timeSlotsUser = day.getTimeSlots(false);
  if ((boolean) context.getAttribute("isClosed")) {
%>

<h2>The Shop is currently closed</h2>
<% } else { %>
<h2>
  Next available time slot is <%=day.getNextAvailableTime()%> Join the Queue</h2>
</div>

<form method="post" action="addUser" class="addUser">
    <div class="container max-width">
        <div class="row">
            <div class="col-xs-6 text-center">
              Name (Required)
              <input type="text" name="name"></input>
            </div>
            <!--div class="col-xs-5">
              Phone or Email (Optional)
              <input type="text" name="phoneemail"></input>
            </div-->
            <div class="col-xs-6 text-center">
                 <input type="submit" name="submit" value="Add to Queue"></input>
            </div>
        </div>
    </div>
</form>

<% } %>

<% if ((adminUser == null) || (!(adminUser.isValid())))
{ %>

<div class="container max-width">
  <div class="row">
<table id="ts">

  <tr>
    <th>Time</th>
    <th>Name</th>
    <!--th>Details</th-->

  </tr>

  <%
    for(int i=0; i < timeSlotsClient.length ; i++){
  %>

    <tr>
        <td class="time">
            <%=timeSlotsClient[i].getHour()%> : <%= timeSlotsClient[i].getStringMinute()%>

        </td>

        <td>
            <%= timeSlotsClient[i].getUser().getName()%>
        </td>
  </tr>
  <% }
  }%>

  </table>
    <!----------------- END TIME SLOTS CLIENT ----------------->

      <% if ((adminUser != null) && (adminUser.isValid()))
    { %>

    <table id="ts">

      <tr>
        <th>Time</th>
        <th>Name</th>
        <th>Options</th>
      </tr>

      <%
        for(int i=0; i < timeSlotsClient.length ; i++){
      %>

      <tr>
        <td class="time" >
          <%=timeSlotsClient[i].getDisplayHour()%> : <%= timeSlotsClient[i].getStringMinute()%>

        </td>

        <td class="name">
          <%= timeSlotsClient[i].getUser().getName()%>
        </td>

    <td>
      <%
          if (!timeSlotsUser[i].getUser().getName().equals("")) {
              if (timeSlotsUser[i].getPaymentValue() != 0) {
      %>
        <p class="name">
            Paid by <%=timeSlotsUser[i].getPayment()%> for $<%=timeSlotsUser[i].getPaymentValue()%>
        </p>
        <% } else { %>
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
        <% }} %>

    </td>
      <%
      }
      %>

  </tr>
    </table>

  <%}%>



<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
  function refreshTable()
  {
    (function() {
      //var timeSlotsJson = "https://clickk-quicklist.appspot.com/currentTimeSlot";
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

<div class="container max-width">
  <div class="row">
<%

  if (adminUser==null)
  {
%>
  Admin Login
  <div class="container">
    <div class="row">
      <div class="col-sm-4">
  <form method="post" action="loginAdmin">
    <input type="text" name="name"></input>
    <input type="text" name="password" type="password"></input>
    <input type="submit" name="submit" value="Submit"></input>
  </form>
      </div>
    </div>
  </div>
<%  } %>

<% if ((adminUser != null) && (adminUser.isValid()))
{ %>

    <h4>Admin Portal</h4>

<div class="container">
  <div class="row">

<div class="col-sm-4">
<form method="post" action="pay">
    <input type="text" value="-1" name="i" hidden="true"></input>
    <input type="submit" name="submit" value="Pay for extra user"></input>
</form>
</div>
<div class="col-sm-4 ">

<form method="post" action="modifyTime">
  <input type="text" name="timePeriod" value="5"></input>
  <input type="text" name="isAdd" value="true" hidden="true"></input>
  <input type="submit" name="submit" value="Add Time"></input>
</form>
</div>
    <div class="col-sm-4">

<form method="post" action="modifyTime">
  <input type="text" name="timePeriod" value="5"></input>
  <input type="text" name="isAdd" value="false" hidden="true"></input>
  <input type="submit" name="submit" value="Subtract Time"></input>
</form>
  </div>
  </div>
</div>

  <div class="container">
    <div class="row">

    <div class="col-sm-4 ">

<form method="post" action="closeDay">
  <input type="submit" name="submit" value="End of Day"></input>
</form>
    </div>
      <div class="col-sm-4 ">


<form method="post" action="openDay">
    Is it a weekend? <input type="checkbox" name="isWeekend" value="false"></input>
  <input type="submit" name="submit" value="Open Day"></input>
</form>
      </div>
      <div class="col-sm-4 ">

<form method="post" action="logoutAdmin">
    <input type="submit" name="submit" value="Log Out"></input>
</form>
  </div>
</div>
  </div>
  </div>
</div>
<%} %>



</body>
</html>

