<%--
  Created by IntelliJ IDEA.
  User: Dylan
  Date: 26/08/2019
  Time: 11:45 am
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="/css/style.css">
    <link href='https://fonts.googleapis.com/css?family=Orbitron' rel='stylesheet' type='text/css'>
</head>
<body>

<h1 class="font-theme text-center margin-top-40 margin-bottom-40">Admin Login</h1>

<div class="container">
    <div class="row justify-content-center">
        <form method="post" action="admin">
            <div class="form-group">
                <label for="userInput">Username</label>
                <input type="text" class="form-control" id="userInput" name="username" required>
            </div>
            <div class="form-group">
                <label for="passInput">Password</label>
                <input type="password" class="form-control" id="passInput" name="password" required>
            </div>
            <div class="form-group">
                <input type="submit" name="Login" value="Login" class="btn btn-danger width-100">
            </div>
        </form>
    </div>
    <% if (request.getParameter("status") != null) {
        if (request.getParameter("status").equals("failed")) {
    %>
    <div class="row justify-content-center">
        <div class="form-group">
            <p class="error">Incorrect login credentials.</p>
        </div>
    </div>
    <% }} %>
</div>

</body>
</html>
