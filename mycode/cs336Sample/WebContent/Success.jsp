<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
    if ((session.getAttribute("uid") == null)) {
%>
	You are not logged in<br/>
	<a href="Main.jsp">Please Login</a>
<%	} else {
%>
	Welcome <%=session.getAttribute("uid")%>  //this will display the username that is stored in the session.
	<br>
	<a href='Logout.jsp'>Log out</a>
<%
    }
%>

</body>
</html>