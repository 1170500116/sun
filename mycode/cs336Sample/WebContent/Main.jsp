<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = UTF-8">
<title>Customer Register</title>
</head>
<body>

😊 New Customer Register 😊
<%
	Constants.init();
%>
<form  method = "post" action = "Register.jsp">
<table>

<tr><td>User Name: </td><td><input type="text" name="uname"></td></tr>
<tr><td>Password: </td><td><input type="password" name="password"></td></tr>
<tr><td>Email: </td><td><input type="text" name="email"></td></tr>
<tr><td>Phone: </td><td><input type="text" name="phone"></td></tr>
<tr><td></td><td><input type="submit" value="Register"></td></tr>
</table>
</form>

</body>
</html>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset = UTF-8">
<title>Current Customer Login</title>
</head>
<body>😊 Login 😊

<form  method = "post" action = "Login.jsp">
<table><tr>
<br>
		<tr>	Customer Type Select:
			<select name="category" size=1>
				<option value="customer">customer</option>
				<option value="administration">administration</option>
				<option value="representative">customer representative</option>
			</select>
		</tr>
	<br>

<td>Uname: </td><td><input type="text" name="uname"></td></tr>
<tr><td>Password: </td><td><input type="password" name="password"></td></tr>
<tr><td></td><td><input type="submit" value="Login"></td></tr>
</table>
</form>
</body>
</html>

	