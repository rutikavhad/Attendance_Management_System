<%@ page import="java.sql.*" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Mark Attendance</title>

<style>
body {
    font-family: Arial;
    background: #f4f6f9;
    text-align: center;
}

.container {
    margin-top: 50px;
}

.card {
    background: white;
    padding: 30px;
    border-radius: 10px;
    display: inline-block;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

select, button {
    padding: 10px;
    margin: 10px;
    width: 200px;
}

button {
    background: #4facfe;
    color: white;
    border: none;
    cursor: pointer;
}

button:hover {
    background: #00c6ff;
}
</style>

</head>
<body>

<div class="container">
<div class="card">

<h2>Mark Attendance</h2>

<form action="<%= request.getContextPath() %>/AttendanceServlet" method="post">

<select name="employee_id" required>
<option value="">Select Employee</option>

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

<option value="<%= rs.getInt("id") %>">
<%= rs.getString("name") %>
</option>
<%
    }
    con.close();
} catch(Exception e){
    out.println("DB Error");
}
%>

</select>

<br>

<button name="action" value="checkin">Check In</button> <button name="action" value="checkout">Check Out</button>

</form>

</div>
</div>

</body>
</html>
