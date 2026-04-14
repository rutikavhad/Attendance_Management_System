<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
String user = (String) session.getAttribute("user");

if(user == null){
response.sendRedirect("login.jsp");
}
%>

<%
String deleteId = request.getParameter("deleteId");

if(deleteId != null){
    try {
        Class.forName("org.postgresql.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/attendance_db",
            "matrix",
            "1234"
        );

        String sql = "DELETE FROM employee WHERE id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(deleteId));

        ps.executeUpdate();

        con.close();

        response.sendRedirect("dashboard.jsp");

    } catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>

<style>
body {
    margin: 0;
    font-family: Arial;
    background: #f4f6f9;
}

.header {
    background: #4facfe;
    color: white;
    padding: 15px;
    text-align: center;
    font-size: 20px;
}

.container {
    padding: 20px;
}

.card {
    background: white;
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 20px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

h3 {
    margin-bottom: 10px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid #ddd;
}

th {
    background: #4facfe;
    color: white;
    padding: 10px;
}

td {
    padding: 8px;
    text-align: center;
}

.btn {
    padding: 8px 12px;
    background: #4facfe;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.btn:hover {
    background: #00c6ff;
}
</style>

</head>

<body>

<div class="header">
    Welcome, <%= user %>
</div>

<div class="container">

<!-- EMPLOYEE LIST -->

<div class="card">
<h3>Employee List</h3>

<table>
<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Department</th>
<th>Actions</th>
</tr>

<%
try {
Class.forName("org.postgresql.Driver");
Connection con = DriverManager.getConnection(
"jdbc:postgresql://localhost:5432/attendance_db",
"matrix",
"1234"
);

Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM employee");

while(rs.next()){

%>

<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("email") %></td>
<td><%= rs.getString("department") %></td>

<td>
    <a href="editEmployee.jsp?id=<%= rs.getInt("id") %>">
        <button>Edit</button>
    </a>

    <a href="dashboard.jsp?deleteId=<%= rs.getInt("id") %>" 
       onclick="return confirm('Delete this employee?')">
        <button style="background:red;">Delete</button>
    </a>
</td>
</tr>

<%
}
con.close();
} catch(Exception e){
out.println("DB Error: " + e.getMessage());
}
%>

</table>
</div>

<!-- TODAY ATTENDANCE -->

<div class="card">
<h3>Today Attendance</h3>

<table>
<tr>
<th>Employee ID</th>
<th>Date</th>
<th>Check In</th>
<th>Check Out</th>
<th>Late (min)</th>
<th>Early Leave</th>
<th>Status</th>
</tr>

<%
try {
Class.forName("org.postgresql.Driver");
Connection con = DriverManager.getConnection(
"jdbc:postgresql://localhost:5432/attendance_db",
"matrix",
"1234"
);


Statement st = con.createStatement();
ResultSet rs = st.executeQuery(
    "SELECT * FROM attendance WHERE date = CURRENT_DATE"
);

while(rs.next()){


%>

<tr>
<td><%= rs.getInt("employee_id") %></td>
<td><%= rs.getDate("date") %></td>
<td><%= rs.getTime("check_in") %></td>
<td><%= rs.getTime("check_out") %></td>
<td><%= rs.getInt("late_minutes") %></td>
<td><%= rs.getInt("early_leave_minutes") %></td>
<td><%= rs.getString("status") %></td>
</tr>

<%
}
con.close();
} catch(Exception e){
out.println("DB Error: " + e.getMessage());
}
%>

</table>
</div>

</div>

</body>
</html>
