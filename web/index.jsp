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
  <link href="//db.onlinewebfonts.com/c/d664bf6951144f64f00f5b48099019d3?family=RefrigeratorDeluxeW01-Bold" rel="stylesheet" type="text/css">
  <link rel="stylesheet" id="astra-theme-css-css" href="https://www.quickcuts.com.au/wp-content/themes/astra/assets/css/minified/menu-animation.min.css?ver=1.6.8" type="text/css" media="all">

</head>
<body>
<style>
  table {
    width: 100%;
  }
  tr:nth-child(even) {background: #CCC}
  tr:nth-child(odd) {background: #FFF}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<h1>Welcome to the Quicklist</h1>

<%
  ServletContext context = request.getServletContext();
  if ((boolean) context.getAttribute("isClosed")) {
%>
<h2>The Shop is currently closed</h2>
<% } else { %>
<h2>Join the Queue</h2>
<form method="post" action="addUser">
  Name (Required)
  <input type="text" name="name"></input>
  Phone or Email (Optional)
  <input type="text" name="phoneemail"></input>
  <input type="submit" name="submit" value="Submit"></input>
</form>

<% } %>
<h2>
  Current Time is <div id="time"></div>
</h2>

<table id="ts">
  <%
    Day day = (Day) context.getAttribute("day");
    HttpSession sesh = request.getSession();
    AdminUser adminUser = (AdminUser) sesh.getAttribute("adminUser");
    TimeSlot[] timeSlots = day.getTimeSlots(); %>
  <tr>
    <th>Time</th>
    <th>Name</th>
    <th>Details</th>
    <th></th>
  </tr>

  <%
    for(int i=0; i < timeSlots.length ; i++){
      Calendar rightNow = Calendar.getInstance();
      int hour = rightNow.get(Calendar.HOUR_OF_DAY);
      int minute = rightNow.get(Calendar.MINUTE);
      if (timeSlots[i].getHour() > hour)
      {
        i++;
      }
  %>

  <tr>
    <td>
      <%=timeSlots[i].getHour()%> : <%= timeSlots[i].getStringMinute()%>

    </td>

    <td>
      <%= timeSlots[i].getUser().getName()%>
    </td>
    <td id="phoneemail">
      <%= timeSlots[i].getUser().getPhoneemail()%>
    </td>
    <td>
      <% if ((adminUser != null) && (adminUser.isValid()))
      {
      %>
      <form method="post" action="pay">
        <input type="text" value="<%=i%>" name="i" hidden="true"></input>
        <input type="submit" name="submit" value="Pay"></input>
      </form>
        <form method="post" action="deleteUser">
          <input type="text" value="<%=i%>" name="i" hidden="true"></input>
          <input type="submit" name="submit" value="Delete"></input>
        </form>
      <%
      }
      %>
    </td>
  </tr>

  <%}%>
</table>

<script>
  function refreshTable()
  {
    (function() {
      var timeSlotsJson = "https://clickk-quicklist.appspot.com/currentTimeSlot";
      //var timeSlotsJson = "http://localhost:8080/currentTimeSlot";
      $.getJSON(timeSlotsJson)
              .done(function (response) {
                var timeslots = response["timeslots"];
                for (i = 0; i < timeslots.length; i++) {
                  console.log(timeslots[i]["time"]);
                  document.getElementById("ts").rows[i+1].cells[0].innerHTML = (timeslots[i]["time"]);
                  document.getElementById("ts").rows[i+1].cells[1].innerHTML = (timeslots[i]["name"]);
                  document.getElementById("ts").rows[i+1].cells[2].innerHTML = (timeslots[i]["details"]);
                }
              });
    })();
  }

  function startTime() {
    var today = new Date();
    var h = today.getHours()%12;
    var m = today.getMinutes();
    var s = today.getSeconds();
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('time').innerHTML =
            h + ":" + m + ":" + s;
    var t = setTimeout(startTime, 500);
  }
  function checkTime(i) {
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
  }

  function hidephoneemail()
  {

    var cell = document.getElementById('phoneemail').innerHTML;
    cell = cell.replace(/(\w{1})(.*)(\w{1})@(.*)/, '$1******$3@$4');
    cell = cell.replace(/(\d{1})(.*)(\d{3})/, '$1******$3')
    document.getElementById('phoneemail').innerHTML = cell;
  }

  $(document).ready(function() {
    startTime();
    setInterval(function () {
      refreshTable();
    }, 5000);
    <% if ((adminUser != null) && (adminUser.isValid()))
{ %>
    hidephoneemail();
    <% } %>
  });

</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<%

  if (adminUser==null)
  {
%>
  <h4>Admin Login</h4>
  <form method="post" action="loginAdmin">
    <input type="text" name="name"></input>
    <input type="text" name="password" type="password"></input>
    <input type="submit" name="submit" value="Submit"></input>
  </form>
<%  } %>

<% if ((adminUser != null) && (adminUser.isValid()))
{ %>

<h4>Add 5</h4>
<form method="post" action="modifyTime">
  <input type="text" name="timePeriod" value="5"></input>
  <input type="text" name="isAdd" value="true" hidden="true"></input>
  <input type="submit" name="submit" value="Submit"></input>
</form>

<h4>Subtract 5</h4>
<form method="post" action="modifyTime">
  <input type="text" name="timePeriod" value="5"></input>
  <input type="text" name="isAdd" value="false" hidden="true"></input>
  <input type="submit" name="submit" value="Submit"></input>
</form>

<h4>Close Day</h4>
<form method="post" action="closeDay">
  <input type="submit" name="submit" value="Submit"></input>
</form>

<h4>Open Day</h4>
<form method="post" action="openDay">
  <input type="submit" name="submit" value="Submit"></input>
</form>

<%} %>
</body>
</html>

