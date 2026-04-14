<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String msg = "";

if(request.getMethod().equalsIgnoreCase("POST")){


String name = request.getParameter("name");
String email = request.getParameter("email");
String dept = request.getParameter("department");

try {
    Class.forName("org.postgresql.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/attendance_db",
        "matrix",
        "1234"
    );

    String sql = "INSERT INTO employee(name, email, department) VALUES(?, ?, ?)";
    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, dept);

    ps.executeUpdate();

    msg = "Employee Added Successfully ✅";

    con.close();

} catch(Exception e){
    msg = "Error: " + e.getMessage();
}

}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Add Employee</title>

<style>
body {
    font-family: Arial;
    background: #f4f6f9;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.card {
    background:white;
    padding:30px;
    border-radius:10px;
    width:350px;
    box-shadow:0 5px 15px rgba(0,0,0,0.2);
}

input {
    width:100%;
    padding:10px;
    margin:10px 0;
}

button {
    width:100%;
    padding:10px;
    background:#4facfe;
    color:white;
    border:none;
}

.msg {
    text-align:center;
    margin-bottom:10px;
    color:green;
}
.error {
    color:red;
}
</style>

</head>
<body>

<div class="card">
<h2>Add Employee</h2>

<% if(!msg.equals("")) { %>
<p class="<%= msg.startsWith("Error") ? "error" : "msg" %>"><%= msg %></p>
<% } %>

<form method="post">

<input type="text" name="name" placeholder="Name" required>
<input type="email" name="email" placeholder="Email" required>
<input type="text" name="department" placeholder="Department" required>

<button type="submit">Add Employee</button>

</form>

</div>

</body>
</html>
