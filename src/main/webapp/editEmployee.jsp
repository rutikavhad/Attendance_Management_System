<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");

String name = "";
String email = "";
String dept = "";

try {
Class.forName("org.postgresql.Driver");


Connection con = DriverManager.getConnection(
    "jdbc:postgresql://localhost:5432/attendance_db",
    "matrix",
    "1234"
);

String sql = "SELECT * FROM employee WHERE id=?";
PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, Integer.parseInt(id));

ResultSet rs = ps.executeQuery();

if(rs.next()){
    name = rs.getString("name");
    email = rs.getString("email");
    dept = rs.getString("department");
}

con.close();


} catch(Exception e){
out.println("Error: " + e.getMessage());
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Edit Employee</title>

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
</style>

</head>
<body>

<div class="card">
<h2>Edit Employee</h2>

<form method="post">

<input type="hidden" name="id" value="<%= id %>">

<input type="text" name="name" value="<%= name %>" required>
<input type="email" name="email" value="<%= email %>" required>
<input type="text" name="department" value="<%= dept %>" required>

<button type="submit">Update</button>

</form>

<%
if(request.getMethod().equalsIgnoreCase("POST")){


String newName = request.getParameter("name");
String newEmail = request.getParameter("email");
String newDept = request.getParameter("department");
String empId = request.getParameter("id");

try {
    Class.forName("org.postgresql.Driver");

    Connection con = DriverManager.getConnection(
        "jdbc:postgresql://localhost:5432/attendance_db",
        "matrix",
        "1234"
    );

    String sql = "UPDATE employee SET name=?, email=?, department=? WHERE id=?";
    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, newName);
    ps.setString(2, newEmail);
    ps.setString(3, newDept);
    ps.setInt(4, Integer.parseInt(empId));

    ps.executeUpdate();

    con.close();

    response.sendRedirect("dashboard.jsp");

} catch(Exception e){
    out.println("Error: " + e.getMessage());
}


}
%>

</div>

</body>
</html>
