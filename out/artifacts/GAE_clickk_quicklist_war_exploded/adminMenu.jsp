<%@ page import="objects.AdminUser" %><%--
  Created by IntelliJ IDEA.
  User: dylan
  Date: 20/08/2019
  Time: 11:36 am
  To change this template use File | Settings | File Templates.
--%>

<%

    AdminUser adminUser = (AdminUser) session.getAttribute("adminUser");
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Portal</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav navbar-center">
            <li class="nav-item active">
                <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Make Payment</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Adjust Times</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/logoutAdmin">Logout, <%= adminUser.getUsername() %></a>
            </li>
        </ul>
    </div>
</nav>