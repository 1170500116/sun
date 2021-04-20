<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();

		//int uid = (Integer)session.getAttribute("uid");
		int bid_id=Integer.valueOf(request.getParameter("bid_id")).intValue();
 		stmt.executeUpdate("delete from bid WHERE bid_id = " + bid_id );
 		out.println("delete bid Sucess");
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("delete bid failed");
	}
	
	out.print("<br><a href='javascript:history.back(-1)'>reutrn</a>");
	//out.print("<br><a href='javascript:history.go(-1)'>reutrn</a>");

%>

</body>
</html>