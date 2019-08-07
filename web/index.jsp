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
    <link type="text/css" rel="stylesheet" href="/css/style.css">

</head>
<body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<h1>Welcome to the Quicklist</h1>

<%
  ServletContext context = request.getServletContext();
  Day day = (Day) context.getAttribute("day");
  HttpSession sesh = request.getSession();
  AdminUser adminUser = (AdminUser) sesh.getAttribute("adminUser");
  TimeSlot[] timeSlots = day.getTimeSlots();
  if ((boolean) context.getAttribute("isClosed")) {
%>

<h2>The Shop is currently closed</h2>
<% } else { %>
<h2>
  Next available time slot is <%=day.getNextAvailableTime()%> Join the Queue</h2>
<form method="post" action="addUser">
    <div class="container">
        <div class="row">
            <div class="col-xs-5 name">
              Name (Required)
              <input type="text" name="name"></input>
            </div>
            <!--div class="col-xs-5">
              Phone or Email (Optional)
              <input type="text" name="phoneemail"></input>
            </div-->
            <div class="col-xs-2 name">
                 <input type="submit" name="submit" value="Add to Queue"></input>
            </div>
        </div>
    </div>
</form>

<% } %>


<table id="ts">

  <tr>
    <th>Time</th>
    <th>Name</th>
    <!--th>Details</th-->
    <th></th>
  </tr>

  <%
    for(int i=0; i < timeSlots.length ; i++){
      Calendar rightNow = Calendar.getInstance();
      int hour = rightNow.get(Calendar.HOUR_OF_DAY);
      int minute = rightNow.get(Calendar.MINUTE);
      /**if (timeSlots[i].getHour() > hour)
      {
        i++;
      }*/
  %>

  <tr>
    <td>
      <%=timeSlots[i].getHour()%> : <%= timeSlots[i].getStringMinute()%>

    </td>

    <td>
      <%= timeSlots[i].getUser().getName()%>
    </td>
    <!--td id="phoneemail">
      <%= timeSlots[i].getUser().getPhoneemail()%>
    </td-->

    <% if ((adminUser != null) && (adminUser.isValid()))
    { %>

    <td>
      <%
        if (timeSlots[i].getPaymentValue() == 0)
        {
      %>
      <form method="post" action="pay">
        <input type="text" value="<%=i%>" name="i" hidden="true"></input>
        <input type="submit" name="submit" value="Pay"></input>
      </form>
        <% }
          else
          { %>
            Paid by <%=timeSlots[i].getPayment()%> for $<%=timeSlots[i].getPaymentValue()%>

         <% } %>
        <form method="post" action="deleteUser">
          <input type="text" value="<%=i%>" name="i" hidden="true"></input>
          <input type="submit" name="submit" value="Delete"></input>
        </form>
    </td>
      <%
      }
      %>
    </td>
  </tr>

  <%}%>
</table>

<script type="text/javascript">
  function refreshTable()
  {
    (function() {
      //
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



  $(document).ready(function() {
    setInterval(function () {
      refreshTable();
    }, 5000);



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

<h4>Pay for extra user</h4>
<form method="post" action="pay">
    <input type="text" value="-1" name="i" hidden="true"></input>
    <input type="submit" name="submit" value="Pay"></input>
</form>

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

<h4>End of Day</h4>
<form method="post" action="closeDay">
  <input type="submit" name="submit" value="Submit"></input>
</form>

<h4>Open Day</h4>
<form method="post" action="openDay">
    Is it a weekend? <input type="checkbox" name="isWeekend" value="false"></input>
  <input type="submit" name="submit" value="Submit"></input>
</form>

<h4>Log Out</h4>
<form method="post" action="logoutAdmin">
    <input type="submit" name="submit" value="Submit"></input>
</form>

<%} %>



</body>
</html>

