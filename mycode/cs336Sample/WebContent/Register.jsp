<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register Succeeded</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String uname = request.getParameter("uname");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String category = "customer";
		

		//Make an insert statement for the bars table:
		String insert = "INSERT INTO user(uid,uname, password, email, phone,category)" + "VALUES (?,?, ?, ?, ?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	
		ps.setInt(1, Constants.uid++);
		ps.setString(2, uname);
		ps.setString(3, password);
		ps.setString(4, email);
		ps.setString(5, phone);
		ps.setString(6, category);
		ps.executeUpdate();

		
	
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Register succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Register failed");
	}
%>
<br>
<a href="javascript:history.back(-1)">reutrn</a>
</body>
</html>