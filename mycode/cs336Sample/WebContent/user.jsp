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
	    int user_id=Integer.valueOf(request.getParameter("user_id")).intValue();
	  		
 	    int uid=(Integer)session.getAttribute("uid");
 	    
 	    ResultSet result;
 		String sql = "SELECT * FROM user WHERE uid = '" + user_id+"'";
 		result = stmt.executeQuery(sql);
		System.out.println("111111111111111");
 		if(result.next()){
 			String uname = result.getString("uname");	
 			String email = result.getString("email");	
 			String phone = result.getString("phone");	
 			String category = result.getString("category");
 			out.println("Welcome to "+uname+"'s HomePage!<br>");
 			out.println("email:"+email+"<br>");
 			if(phone!=null&&phone!=""){
 				out.println("phone:"+phone+"<br>");
 			} 			
 			out.println("category:"+category+"<br>");
 			String user_category =(String) session.getAttribute("user_category");
 			System.out.println(user_category);
 			if(user_category.equals("representative")){
 				String linshi=String.format("<form  method = 'post' action = 'change_password.jsp?user_id=%d'>"+
						"new password:<input type='text' name='password' >"+
						"<input type='submit' value='change password' /></form><br>\n",user_id);
 				out.println(linshi+
 			 			"<form  method = 'post' action = 'Delete_user.jsp?user_id="+user_id+"'><td><input type='submit' value='cancel account' /></td></form>");
 			}
 			
 			
 			
 		}
 		
 		out.println("Autions~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>");
 		
 		sql = "SELECT * FROM aution WHERE seller_id = " + user_id;
 		result = stmt.executeQuery(sql);
 		String buffer="";
		buffer+="<table>\n";
		System.out.println("22222222222222");
		while(result.next()){				
			String image = result.getString("image");
			String _category = result.getString("category");
			String _subcategory = result.getString("subcategory");
			String _description = result.getString("description");
			int seller_id = result.getInt("seller_id");
			double _original_price= result.getDouble("original_price");
			double increment= result.getDouble("increment");
			String start_time= result.getString("start_time");
			String end_time= result.getString("end_time");	
			int  aution_id = result.getInt("aution_id");
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
					 
					 
					"<tr><td>\n"+
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
					"<a href='user.jsp?user_id=%d'>seller's HomePage</a>\n"+
					"<br>"+	
					"<a href='Bidding_historys.jsp?aution_id=%d'>Bidding historys</a>\n"+
					"<br>"+
					"------------------------------------------------------------\n"+
					"<br>"+	
				
					"</td></tr>\n",
					image,_category,_subcategory,_description,_original_price,max_bid_price,start_time,end_time,jieshu,seller_id,aution_id);  
			
		}
		buffer+="</table>\n";
		out.println(buffer);
		
		
		
		
 		out.println("Bids~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>");
 		
 		
 		
 		
 		
 		sql = "SELECT * FROM bid WHERE buyer_id = '" + user_id+"'";
 		result = stmt.executeQuery(sql);
 	    buffer="";
		buffer+="<table>\n";
		System.out.println("33333333333333");
		while(result.next()){			
			//bid
			double original_price= result.getDouble("original_price");
			double increment= result.getDouble("increment");
			double now_bid_price= result.getDouble("now_bid_price");
			String last_bid_time= result.getString("last_bid_time");
			int aution_id = result.getInt("aution_id");
			int bid_id = result.getInt("bid_id");		
			//aution		
			Statement stmt1 = con.createStatement();
			String sql_ = "SELECT * FROM aution WHERE aution_id = '" + aution_id+"'";
			ResultSet result_ = stmt1.executeQuery(sql_);	
			buffer+="<tr><td>\n";
			if(result_.next()){	
				String image = result_.getString("image");
				String _category = result_.getString("category");
				String _subcategory = result_.getString("subcategory");
				String _description = result_.getString("description");
				int seller_id = result_.getInt("seller_id");
				double _original_price= result_.getDouble("original_price");
				double _increment= result_.getDouble("increment");
				String start_time= result_.getString("start_time");
				String end_time= result_.getString("end_time");				
				int  max_bid_id = result_.getInt("max_bid_id");
				double max_bid_price = result_.getDouble("max_bid_price");
				double minprice = result_.getDouble("minprice");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");			
				Date now_time = sdf.parse(sdf.format(new Date()));
				String jieshu="";
				
				String sql_1 = "SELECT * FROM bid WHERE aution_id = '" + aution_id+"' and bid_id= '"+max_bid_id+"'";
				Statement stmt2 = con.createStatement();
				ResultSet  result_1 = stmt2.executeQuery(sql_1);	
				int max_buyer_id =0;
				if(result_1.next()){
					max_buyer_id = result_1.getInt("buyer_id");
				}
				if(max_bid_id!=-1){
					if(now_bid_price<max_bid_price||(now_bid_price==max_bid_price&&max_bid_id!=bid_id)){
						if(user_id==uid){
							jieshu +="the max bid price is not from you,a higher bid has been placed!<br>" ;
						}else{
							jieshu +="the max bid price is not from He/She,,a higher bid has been placed!<br>" ;
						}
					}
				}
				
				if(now_time.after(sdf.parse(end_time))){				
					
					jieshu +="the aution is over<br>";
					if(max_bid_id!=-1&&minprice<=max_bid_price){
					jieshu += String.format("<a href='user.jsp?user_id=%d'>winner's HomePage</a>\n",max_buyer_id);
					
						if(max_buyer_id==user_id){	
							if(user_id==uid){
								jieshu += String.format("<br>YOU are the winner!");
							}else{
								jieshu += String.format("<br>He/She is the winner!");
							}					
						}
					}
						
				}else  if(max_bid_id!=-1){
					jieshu += String.format("<a href='user.jsp?user_id=%d'>The buyer given the highest price till now's HomePage</a><br>",max_buyer_id);
					
				}
				
				
				
				buffer+=	String.format(	
						 "Aution details:<br>"+		
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
						"%s"+	
						"</form>\n"+
						"<a href='user.jsp?user_id=%d'>seller's HomePage</a>\n"+
						"<br>"+	
						"<a href='Bidding_historys.jsp?aution_id=%d'>Bidding historys</a>\n"+
						"<br>",		
						image,_category,_subcategory,_description,original_price,max_bid_price,start_time,end_time,jieshu,seller_id,aution_id);  
			}
			
			
			
			 buffer+=	String.format(	
					 
					"Bidding details:<br>"+
					"original_price:%.2f\n"+
					"<br>"+							
					"increment:%.2f\n"+
					"<br>"+	
					"now_bid_price:%.2f\n"+
					"<br>"+			
					"last_bid_time:%s\n"+
					"<br>"+			
					
					"------------------------------------------------------------\n"+
					"<br>"+	
				
					"</td></tr>\n",
					original_price,increment,now_bid_price,last_bid_time);  
			
		}
		buffer+="</table>\n";
		out.println(buffer);
		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		
		
		out.print("Bidding histories check succeeded");

	} catch (Exception ex) {
		out.print(ex);
		out.print("Bidding histories check failed");
	
	}
	
%>
<br>
<a href="javascript:history.back(-1)">reutrn</a>
</body>
</html>