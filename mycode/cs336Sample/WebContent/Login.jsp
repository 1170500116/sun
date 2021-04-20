<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
		String category = request.getParameter("category");
		
		
		//Search on current database:
		
		ResultSet result = stmt.executeQuery("SELECT * FROM user WHERE uname = '" + uname + "' and password = '" + password+"'");
		if(result.next()){				
			String _category = result.getString("category");
			if(category.equals(_category)){
				out.print("You are "+_category+","+uname);
			}else{
				out.print("You are not a current end-users . Please register before login.");
			}
			session.setAttribute("uid", result.getInt("uid")); // the username will be stored in the session
			session.setAttribute("user_category", _category); 
			System.out.println(_category+"?????????????????");
			out.println("<a href='logout.jsp'>Log out</a>");
		
			if((category).equals("customer"))
			{				
				response.sendRedirect("cuspage.jsp");
			}else if ((category).equals("administration")){
				response.sendRedirect("administration.jsp");
			}else if ((category).equals("representative")){
				response.sendRedirect("representative.jsp");
			}
		}
		else
		{
			out.println("You are not a current end-users . Please register before login.\n<a href='Main.jsp'>try again</a>");
		
		}
	
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("Register failed");
	}
	
%>
</body>
</html>