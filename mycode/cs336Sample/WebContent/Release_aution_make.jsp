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
		String image =  (String)session.getAttribute("realFilePath");
		System.out.println("image:"+image);
		int aution_id = Constants.aution_id++;
		double original_price = 0.0;
		double increment = 0.0;
		double minprice = 0.0;
		if(category==null||category.equals("category")){
			request.setAttribute("news", "category must be selected");			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}
		if(subcategory==null||subcategory.equals("all")){
			request.setAttribute("news", "subcategory must be selected");			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}
		try{
			original_price = Double.valueOf(request.getParameter("original_price"));
		}catch(NumberFormatException e){
			request.setAttribute("news", "original_price input error:"+e);			
			request.getRequestDispatcher("print.jsp").forward(request, response);

		}
		
		try{
			increment = Double.valueOf(request.getParameter("increment"));
		}catch(NumberFormatException e){
			request.setAttribute("news", "increment input error:"+e);			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}
		
		try{
			minprice = Double.valueOf(request.getParameter("minprice"));
		}catch(NumberFormatException e){
			request.setAttribute("news", "minprice input error:"+e);			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}	
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date end_time = null;	
		Date start_time = sdf.parse(sdf.format(new Date()));

		try {
			end_time = sdf.parse(request.getParameter("end_time"));
		} catch (Exception e) {
			request.setAttribute("news", "end_time input error:"+e);			
			request.getRequestDispatcher("print.jsp").forward(request, response);	
		}
		if(start_time.after(end_time)){
			request.setAttribute("news", "end_time input error:end_time must be later for now");			
			request.getRequestDispatcher("print.jsp").forward(request, response);	
		}
		
		
		if(image==null){
			if(category.equals("vehicles")){
				image = Constants.image_vehicle;
			}else if(category.equals("clothing")){
				image = Constants.image_clothing;
			}else if(category.equals("computers")){
				image = Constants.image_computer;
			}
		}
		
		
		//Make an insert statement for the bars table:
		 String sql = "INSERT INTO aution (aution_id,category,subcategory,description,seller_id,image,original_price,increment,minprice,start_time,end_time)" +
                 "VALUES (?, ?,?, ?,?, ?,?, ?,?, ?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(sql);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, aution_id);
		ps.setString(2, category);
		ps.setString(3, subcategory);
		if(description.equals(Constants.default_description)){
			description="";
		}
		ps.setString(4, description);
		ps.setInt(5, (Integer)session.getAttribute("uid"));
		ps.setString(6, image);		
		ps.setDouble(7, original_price);
		ps.setDouble(8, increment);
		ps.setDouble(9, minprice);
		ps.setString(10, sdf.format(start_time));
		ps.setString(11, sdf.format(end_time));
	
		ps.executeUpdate();
		
	
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		session.setAttribute("realFilePath", null);
		session.setAttribute("news", null);
		out.print("Release autions succeeded");

	} catch (Exception ex) {
		out.print(ex);
		out.print("Release autions failed");
	
	}
	
%><br>


<a href="Release_aution.jsp">reutrn</a>
</body>
</html>