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
	    int aution_id=Integer.valueOf(request.getParameter("aution_id")).intValue();
 	    int buyer_id=(Integer)session.getAttribute("uid");
 	    
 	    
 	   ResultSet result;
 
		String sql = String.format("SELECT * FROM bid WHERE buyer_id=%d and aution_id=%d" ,buyer_id,aution_id);
		result = stmt.executeQuery(sql);
		System.out.println(sql+"\n");
		if(result.next()){
			System.out.println("you have already bid for this aution,you cannot bid repeated");
			request.setAttribute("news", "you have already bid for this aution");			
			request.getRequestDispatcher("print.jsp").forward(request, response);	
			return;
		}
		
		
		sql = "SELECT * FROM aution WHERE aution_id = " + aution_id;
		result = stmt.executeQuery(sql);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date now_time = sdf.parse(sdf.format(new Date()));
		Date end_time = null;	
		if(result.next()){		
			end_time = sdf.parse(result.getString("end_time"));			
		}
		if(now_time.after(end_time)){
			request.setAttribute("news", "the aution is to the end_time,the aution is over");			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}
		
		
	    double original_price = 0.0;
		double increment = 0.0;
		double maxprice = 0.0;
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
			maxprice = Double.valueOf(request.getParameter("maxprice"));
		}catch(NumberFormatException e){
			request.setAttribute("news", "maxprice input error:"+e);			
			request.getRequestDispatcher("print.jsp").forward(request, response);
		}	
	  
	    double now_bid_price=original_price;
	     sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String last_bid_time=sdf.format(new Date());
	
		
		//Make an insert statement for the bars table:
		 sql = "INSERT INTO bid " +
                 "VALUES (?, ?,?, ?,?, ?,?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(sql);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		int bid_id = Constants.bid_id++;
		ps.setInt(1,bid_id);
		ps.setInt(2, aution_id);
		ps.setInt(3, buyer_id);
		ps.setDouble(4, original_price);
		ps.setDouble(5, increment);
		ps.setDouble(6, maxprice);
		ps.setDouble(7, now_bid_price);
		ps.setString(8, last_bid_time);
		
	
		ps.executeUpdate();
		
		System.out.println("11111111111");
	
 		sql = "SELECT * FROM bid WHERE aution_id = '" + aution_id+"'" ;	
 		result = stmt.executeQuery(sql);
 		Map<Integer,Double> hashmap = new HashMap<Integer,Double>();
 		while(result.next()){
 			hashmap.put(result.getInt("bid_id"),result.getDouble("maxprice"));
 		}
		System.out.println("22222222");
 		if(hashmap.size()==1){
 			System.out.println("3333333");
 			sql = "update aution set max_bid_id=?, max_bid_price=? where aution_id=?";
 			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bid_id);
			pstmt.setDouble(2, now_bid_price);
			pstmt.setInt(3, aution_id);
			pstmt.executeUpdate();
 		}else{
 			System.out.println("44444444444");
 			sql = "SELECT * FROM aution WHERE aution_id = '" + aution_id+"'" ;	
 			stmt = con.createStatement();
 			result = stmt.executeQuery(sql);
 			int  max_bid_id=-1;double max_bid_price=0.0;double aution_increment=0.0;double next_aution_min_price=0.0 ;
 			if(result.next()){
 				max_bid_id = result.getInt("max_bid_id");
 	 	 		max_bid_price =  result.getDouble("max_bid_price");
 	 	 		aution_increment = result.getDouble("increment");
 	 	 		next_aution_min_price = aution_increment+max_bid_price;
 			}
 			
 			
 			List<Map.Entry<Integer, Double>> list = new ArrayList<Map.Entry<Integer, Double>>(hashmap.entrySet());
 			Collections.sort(list, new Comparator<Map.Entry<Integer, Double>>() {
 				@Override
 				public int compare(Map.Entry<Integer, Double> o1, Map.Entry<Integer, Double> o2) {
 					//return o1.getValue().compareTo(o2.getValue());
 					return o2.getValue().compareTo(o1.getValue());
 				}
 			});
 			System.out.println("555555");
 			int i = 0;
 			int first_bid_id = -1;
 			double first_maxprice=0.0;
 			int second_bid_id=-1;
 			double second_maxprice=0.0;
 			
 			for (Map.Entry<Integer, Double> mapping : list) {
 				if(i==0){
 				first_bid_id=mapping.getKey();
 				first_maxprice=mapping.getValue();}
 				else if(i==1){
 					second_bid_id=mapping.getKey();
 					second_maxprice=mapping.getValue(); 					
 				}else{
 					int third_bid_id=mapping.getKey(); 					
 		 			double third_maxprice=mapping.getValue(); 		
 		 			sql = "update bid set now_bid_price=?, last_bid_time=? where bid_id=?";
 		 			PreparedStatement pstmt = con.prepareStatement(sql);
 		 			pstmt.setDouble(1, third_maxprice);
 		 			pstmt.setString(2, sdf.format(now_time));
 					pstmt.setInt(3, third_bid_id);
 					pstmt.executeUpdate();
 				}
 				i++;			
 			}
 			sql = "update aution set max_bid_id=?, max_bid_price=? where aution_id=?";
 			PreparedStatement pstmt = con.prepareStatement(sql);
 			pstmt.setInt(1, first_bid_id);
 			if(first_maxprice==second_maxprice){
 				String sql_ = "update bid set now_bid_price=?, last_bid_time=? where bid_id=?";
	 			PreparedStatement pstmt_ = con.prepareStatement(sql_);
	 			pstmt_.setDouble(1, first_maxprice);
	 			pstmt_.setString(2, sdf.format(now_time));
	 			pstmt_.setInt(3, first_bid_id);
	 			pstmt_.executeUpdate();
	 			pstmt_.setDouble(1, second_maxprice);
	 			pstmt_.setString(2, sdf.format(now_time));
	 			pstmt_.setInt(3, second_bid_id);
	 			pstmt_.executeUpdate();
 				if(first_maxprice>=next_aution_min_price){
 					pstmt.setDouble(2, second_maxprice);
 					pstmt.setInt(3, aution_id);
 					pstmt.executeUpdate();
 				} 				
 			}else{ 				
 				String slq = "SELECT * FROM bid WHERE aution_id = '" + aution_id+"' and bid_id = '" + first_bid_id+"'";
 				result = stmt.executeQuery(slq);
 				double first_original_price = 0.0;
 				double first_increment = 0.0; 						
 				if(result.next()){
 					first_original_price= result.getDouble("original_price");
 					first_increment= result.getDouble("increment");
 				} 				
 				double ans = first_original_price;
 				if(second_maxprice>=first_original_price){
 					int geshu = (int)((second_maxprice-first_original_price)/first_increment);
 					ans = first_original_price+(geshu+1)*first_increment;
 				}
 				
 				if(ans<next_aution_min_price){
 					int geshu = (int)((next_aution_min_price-first_original_price)/first_increment);
 					ans = first_original_price+(geshu+1)*first_increment;
 				}
 				
 				ans = Double.min(first_maxprice,ans);
 				
 				if(ans>=next_aution_min_price){
 					pstmt.setDouble(2, ans);
 					pstmt.setInt(3, aution_id);
 					pstmt.executeUpdate();
 				}
 				
 				
 				
 				String sql_ = "update bid set now_bid_price=?, last_bid_time=? where bid_id=?";
	 			PreparedStatement pstmt_ = con.prepareStatement(sql_);
	 			pstmt_.setDouble(1, ans);
	 			pstmt_.setString(2, sdf.format(now_time));
	 			pstmt_.setInt(3, first_bid_id);
	 			pstmt_.executeUpdate();
	 			pstmt_.setDouble(1, second_maxprice);
	 			pstmt_.setString(2, sdf.format(now_time));
	 			pstmt_.setInt(3, second_bid_id);
	 			pstmt_.executeUpdate();
 				
 			}
 			
 		}
 		
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		
		out.print("Release autions succeeded");

	} catch (Exception ex) {
		out.print(ex);
		out.print("Release autions failed");
	
	}
	
%>
<br>
<a href="javascript:history.back(-2)">reutrn</a>
</body>
</html>