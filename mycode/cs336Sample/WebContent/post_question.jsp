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
		String question = request.getParameter("question");
		int uid = (Integer)(session.getAttribute("uid") );
		
		if(question==null||question==""){
			request.setAttribute("news", "question input error:null");			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}
		//Make an insert statement for the bars table:
		String insert = "INSERT INTO qanda(qanda_id,wen_id, question)" + "VALUES (?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	
		ps.setInt(1, Constants.qanda_id++);
		ps.setInt(2, uid);
		ps.setString(3, question);
		ps.executeUpdate();

		
	
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Post question succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Post question failed");
	}
%>
<br>
<a href="javascript:history.back(-1)">reutrn</a>
</body>
</html>