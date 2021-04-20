<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript">

function city(obj)
{   
	var index =obj.selectedIndex;
	var te =obj.options[index].text; 
	var se =document.getElementById("b").options;
 	se.length=0;
	switch(te)
	{ 
	 case "category":
		  var op =new Option("all","all");
		  se.add(op);
	  case "vehicles":
		  var op =new Option("all","all");
		  se.add(op);
		  op =new Option("truck","truck");
	      se.add(op);
          op =new Option("motorbike","motorbike");
          se.add(op);	          
          op =new Option("car","car");
          se.add(op);
	  break;
	  case "clothing":
		  var op =new Option("all","all");
		  se.add(op);
		  op =new Option("Sweater","Sweater");
	      se.add(op);
          op =new Option("Shoes","Shoes");
          se.add(op);	          
          op =new Option("Coat","Coat");
          se.add(op);
	  break;	
	  case "computers":
		  var op =new Option("all","all");
		  se.add(op);
		  op =new Option("Lenovo","Lenovo");
	      se.add(op);
          op =new Option("HP","HP");
          se.add(op);	          
          op =new Option("Dell","Dell");
          se.add(op);
	  break;
	}

}

</script>
</head>
<body>
Release aution!
<table>
<%!
	double total_earnings(String category,String subcategory, String seller_id){
		double ans =0.0;
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			int _seller_id = -1;
			if(seller_id!=null&&!seller_id.equals("-1")){
				_seller_id = Integer.valueOf(seller_id)	;
			}
			String sql ="";
			System.out.println(category);
			
			if(category==null||category.equals("category")){
				sql = "SELECT * FROM aution";
				if(_seller_id!=-1){
					sql+=" WHERE seller_id = '" + _seller_id+"'" ;
				}
			}else{
				if(subcategory==null||subcategory.equals("all")){
					sql = "SELECT * FROM aution WHERE category = '" + category+"'" ;
				}else{
					sql = "SELECT * FROM aution WHERE category = '" + category + "' and subcategory = '" + subcategory+"'";

				}
				
				if(_seller_id!=-1){
					sql+=" and seller_id = '" + _seller_id+"'" ;
				}
			}
			
			
			ResultSet  result = stmt.executeQuery(sql);	
			while(result.next()){
				int  max_bid_id = result.getInt("max_bid_id");
				double max_bid_price = result.getDouble("max_bid_price");
				double minprice = result.getDouble("minprice");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");			
				Date now_time = sdf.parse(sdf.format(new Date()));
				String end_time= result.getString("end_time");	
				if(now_time.after(sdf.parse(end_time))){
					if(max_bid_id!=-1&&minprice<=max_bid_price){
						ans +=max_bid_price;
					}
				}
			}		
			con.close();
		} catch (Exception ex) {
			System.out.println(ex);
		
		}		
	
		return ans;
	}

	String best_selling_items(){
		String buffer=""; 
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
  
			String sql = "select count(bid_id) as num,aution_id from bid  group by aution_id";
			int max_num = -1;
			int max_aution_id=-1;
			ResultSet  result = stmt.executeQuery(sql);	
			while(result.next()){
				int  aution_id = result.getInt("aution_id");
				int  num = result.getInt("num");
				if(num>max_num){
					max_num=num;
					max_aution_id=aution_id;
				}
			}	
			sql = "SELECT * FROM aution WHERE aution_id = '" + max_aution_id+"'" ;
			result = stmt.executeQuery(sql);	
			
			while(result.next()){				
				String image = result.getString("image");
				String _category = result.getString("category");
				String _subcategory = result.getString("subcategory");
				String _description = result.getString("description");
				int seller_id = result.getInt("seller_id");
				double original_price= result.getDouble("original_price");
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
						"<a href='user.jsp?user_id=%d'>seller's HomePage</a>\n"+
						"<br>"+	
						"<a href='Bidding_historys.jsp?aution_id=%d'>Bidding historys</a>\n"+
						"<br>",
						
						image,_category,_subcategory,_description,original_price,max_bid_price,start_time,end_time,jieshu,seller_id,aution_id);  
				
			}
			con.close();
		} catch (Exception ex) {
			System.out.println(ex);
		
		}		
	
		return buffer;
	}
	String best_buyers(){
		String buffer=""; 
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
  
			String sql = "select count(bid_id) as num,buyer_id from bid  group by buyer_id";
			int max_num = -1;
			int max_buyer_id=-1;
			ResultSet  result = stmt.executeQuery(sql);	
			while(result.next()){
				int  buyer_id = result.getInt("buyer_id");
				int  num = result.getInt("num");
				if(num>max_num){
					max_num=num;
					max_buyer_id=buyer_id;
				}
			}	
			 buffer+=	String.format(	
					 "<a href='user.jsp?user_id=%d'>best_buyer's HomePage</a>\n",max_buyer_id);
				
			con.close();
		} catch (Exception ex) {
			System.out.println(ex);
		
		}		
	
		return buffer;
	}



	
%>

<br>total_earnings :<%=total_earnings(null,null,"-1") %>

<tr>
<form  method = "post" >

<td>select aution category:</td>
<td>

	<select class="form-control" name="category" size=1  onchange="city(this)" >
		<option value="category">category</option>
		<option value="vehicles" >vehicles</option>
		<option value="clothing">clothing</option>
		<option value="computers">computers</option>
	</select>
</td>
<td>
	<select name="subcategory" size=1  id="b">
		<option value="all">all</option>		
	</select>
</td>
<td>seller_id:</td>
<td><input type="text" name="seller_id" value="-1"></td>


<td><input type="submit" value="Calculate" style="margin-left:10px; margin-bottom:20px" /></td>
<%-- <td><input type="submit" value="Calculate" onclick="<%out.print("<br>ac :"+total_earnings(request.getParameter("category"),request.getParameter("subcategory")));%>" style="margin-left:10px; margin-bottom:20px" /></td> --%>
</tr>

<tr><td>
<br>ans :<%=total_earnings(request.getParameter("category"),request.getParameter("subcategory"),request.getParameter("seller_id")) %>
</td></tr>

</form>

</table>
<tr><td>
<br>best-selling items:<%=best_selling_items() %>
</td></tr>


<tr><td>
<br>best buyers:<%=best_buyers() %>
</td></tr>
<form  method = "post" action = "Logout.jsp">	
<td><input type="submit" value="logout" /></td>
</form>
</body>
</html>
