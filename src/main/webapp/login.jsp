<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<style>
body {
    font-family: Arial;
    background: linear-gradient(135deg,#4facfe,#00f2fe);
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

.box {
    background:white;
    padding:30px;
    border-radius:10px;
    width:300px;
    text-align:center;
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

.error{
    color:red;
}
</style>

</head>

<body>

<div class="box">
<h2>Login</h2>

<%
String error=request.getParameter("error");
if("1".equals(error)){
%>

<p class="error">Invalid Email or Password</p>
<% } %>

<form action="<%= request.getContextPath() %>/LoginServlet" method="post">
<input type="email" name="email" placeholder="Email" required>
<input type="password" name="password" placeholder="Password" required>
<button type="submit">Login</button>
</form>

</div>

</body>
</html>
