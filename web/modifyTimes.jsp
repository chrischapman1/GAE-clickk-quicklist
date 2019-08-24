<%--
  Created by IntelliJ IDEA.
  User: dylan
  Date: 23/08/2019
  Time: 1:14 pm
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Modify Times</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link type="text/css" rel="stylesheet" href="/css/style.css">
    <link href='https://fonts.googleapis.com/css?family=Orbitron' rel='stylesheet' type='text/css'>
</head>
<body>

<jsp:include page="/adminMenu.jsp" />

<div class="container">
    <div class="row justify-content-center">
        <h1 class="margin-top-40 margin-bottom-40 ">Modify Times</h1>
    </div>
    <div class="row justify-content-center">
        <form action="modifyTime" method="post">
            <div class="form-group">
                <label for="modifyType" cl>Adjustment Type</label>
                <select id="modifyType" name="modifyType" class="form-control" required>
                    <option value="add" selected>Add</option>
                    <option value="subtract">Subtract</option>
                </select>
            </div>
            <div class="form-group">
                <label for="timeValue">Adjustment Type</label>
                <input type="number" id="timeValue" name="timeValue" value="5" step="5" class="form-control" required>
            </div>
            <div class="form-group">
                <input type="submit" value="Make Adjustment" class="btn btn-danger width-100">
            </div>
        </form>
    </div>
</div>
</body>
</html>
