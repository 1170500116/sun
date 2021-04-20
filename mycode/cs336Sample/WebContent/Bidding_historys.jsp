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
	    ResultSet result;
	    String sql = "SELECT * FROM aution WHERE aution_id = '" + aution_id+"'";	    
	    result = stmt.executeQuery(sql);	
	    String buffer="";
	
		if(result.next()){	
			String image = result.getString("image");
			String _category = result.getString("category");
			String _subcategory = result.getString("subcategory");
			String _description = result.getString("description");
			int seller_id = result.getInt("seller_id");
			double original_price= result.getDouble("original_price");
			double increment= result.getDouble("increment");
			String start_time= result.getString("start_time");
			String end_time= result.getString("end_time");				
			int  max_bid_id = result.getInt("max_bid_id");
			double max_bid_price = result.getDouble("max_bid_price");
			double minprice = result.getDouble("minprice");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");			
			Date now_time = sdf.parse(sdf.format(new Date()));
			String jieshu="";
			int max_buyer_id = 0;
			String sql_ = "SELECT * FROM bid WHERE aution_id = '" + aution_id+"' and bid_id='"+max_bid_id+"'";
			Statement stmt1 = con.createStatement();
			ResultSet  result_ = stmt1.executeQuery(sql_);	
			if(result_.next()){
				max_buyer_id = result_.getInt("buyer_id");				
		
			}
			if(now_time.after(sdf.parse(end_time))){
				jieshu += "the aution is over.<br>";
				if(max_bid_id!=-1&&minprice<=max_bid_price){
					jieshu+=String.format("knock down price:%s<br>",max_bid_price);
					jieshu += String.format("<a href='user.jsp?user_id=%d'>winner's HomePage</a>\n",max_buyer_id);
				
				}
			}else if(max_bid_id!=-1){
				jieshu += String.format("<a href='user.jsp?user_id=%d'>The buyer given the highest price till now's HomePage</a>",max_buyer_id);
			}

			 buffer+=	String.format(	
					 					
					"<form  method = 'post'  >\n"+		
					"<br>"+
					"<img src='%s' width='120', height='80' />\n"+
					"<br>"+				
					"category:%s\t\t\t subcategory:%s\n"+
					"<br>"+			
					"description:%s\n"+
					"<br>"+			
					"original price:%.2f\t\t\t now max bid price:%.2f\n"+
					"<br>"+			
					"start_time:%s\t\t\t end_time:%s\n"+	
					"<br>"+	
					"%s<br>"+	
					"</form>\n"+
					"------------------------------------------------------------\n"+
					"<br>",				
					image,_category,_subcategory,_description,original_price,max_bid_price,start_time,end_time,jieshu);  
			 
			 

				 
			 out.println(buffer);
		}		
		
	    
	    
		sql = "SELECT * FROM bid WHERE aution_id = '" + aution_id+"'";
		result = stmt.executeQuery(sql);	
		
 	    int uid=(Integer)session.getAttribute("uid");
 	    
 	    
 	    buffer="";
		buffer+="<table>\n";
	
		while(result.next()){			
			//bid
			int bid_id = result.getInt("bid_id");
			int buyer_id = result.getInt("buyer_id");
			double original_price= result.getDouble("original_price");
			double increment= result.getDouble("increment");
			double now_bid_price= result.getDouble("now_bid_price");
			String last_bid_time= result.getString("last_bid_time");
			//aution
			String sql_ = "SELECT * FROM aution WHERE aution_id = '" + aution_id+"'";
		    Statement stmt1 = con.createStatement();
			ResultSet result_ = stmt1.executeQuery(sql_);
		    String jieshu="";
	
		    if(result_.next()){
		    	String end_time= result_.getString("end_time");	
				int  max_bid_id = result_.getInt("max_bid_id");
				double max_bid_price = result_.getDouble("max_bid_price");
				double minprice = result_.getDouble("minprice");		
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");			
				Date now_time = sdf.parse(sdf.format(new Date()));
				
				
				if(now_time.after(sdf.parse(end_time))){				
					if(max_bid_id!=-1&&minprice<=max_bid_price&&max_bid_id==bid_id){					
						jieshu += String.format("the aution is over,and it is the winner!");
					}
				}
		    }
			
			
			 buffer+=	String.format(	
					 
					 
					"<tr><td>\n"+
					"<form  method = 'post'  >\n"+	
					"<br>"+		
					"buyer_id:%d\n"+
					"<br>"+			
					"original_price:%.2f\n"+
					"<br>"+							
					"increment:%.2f\n"+
					"<br>"+	
					"now_bid_price:%.2f\n"+
					"<br>"+			
					"last_bid_time:%s\n"+
					"<br>"+						
					"%s\n<br>"+	
					"</form>\n"+
					"<a href='user.jsp?user_id=%d'>Buyers's HomePage</a>\n"	,
					buyer_id,original_price,increment,now_bid_price,last_bid_time,jieshu,buyer_id);  
			 String user_category =(String) session.getAttribute("user_category");
	 			if(user_category.equals("representative")){
	 				buffer+=String.format("<form  method = 'post' action = 'delete_bid.jsp?bid_id=%d'>"+
							"<input type='submit' value='delete_bid' /></form><br>\n",
							bid_id);
	 			}
	 			buffer+=String.format(		
								"<br>"+		
								"------------------------------------------------------------\n"+
								"<br>"+	
								"</td></tr>\n");
			
		}
		buffer+="</table>\n";
		out.println(buffer);
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		
		out.println("Bidding histories check succeeded");

	} catch (Exception ex) {
		out.println(ex);
		out.println("Bidding histories check failed");
	
	}
	
%>
<a href="javascript:history.back(-1)">reutrn</a>
</body>
</html>