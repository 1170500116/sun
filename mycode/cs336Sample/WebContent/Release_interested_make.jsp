<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
	
		String category = request.getParameter("category");
		
		String subcategory = request.getParameter("subcategory");

		String description = request.getParameter("description");
		
		int interested_id = Constants.interested_id++;
		
		if(category==null||category.equals("category")){
			request.setAttribute("news", "category must be selected");			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}
		if(subcategory==null||subcategory.equals("all")){
			request.setAttribute("news", "subcategory must be selected");			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}
		
		
		//Make an insert statement for the bars table:
		 String sql = "INSERT INTO interested (interested_id,category,subcategory,description,uid)" +
                 "VALUES (?, ?,?, ?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(sql);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, interested_id);
		ps.setString(2, category);
		ps.setString(3, subcategory);
		if(description.equals(Constants.default_description)){
			description="";
		}
		ps.setString(4, description);
		ps.setInt(5, (Integer)session.getAttribute("uid"));
		
		ps.executeUpdate();
		
	
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
	
		out.print("Release interested autions succeeded");

	} catch (Exception ex) {
		out.print(ex);
		out.print("Release interested autions failed");
	
	}
	
%><br>


<a href="javascript:history.back(-1)">reutrn</a>
</body>
</html>