<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
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

<br>news:<%=request.getAttribute("news") %>
<br>upload path:<%=request.getAttribute("realFilePath")%>
<tr><td>

<form action="UpLoadServet"   method="post" enctype="multipart/form-data">

 select an image<input type="file" name="spicture">
 <br>
<input type="submit" value="upload"><br><br>


</form>

</td></tr>


<form  method = "post"  action = "Release_aution_make.jsp">
<%
System.out.println("aaa:"+ request.getAttribute("realFilePath"));
session.setAttribute("realFilePath", request.getAttribute("realFilePath"));

%>
<tr><td>select aution category:</td>
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
</tr>



<tr>
<td>add description:</td>
<td><input type="text" name="description" value="<%=Constants.default_description %>"></td>
</tr>


<tr>
<td>set  an initial price:</td>
<td><input type="text" name="original_price" value="120.0"></td>
</tr>


<tr>
<td>set an increment for bids:</td>
<td><input type="text" name="increment" value="1.0"></td>
</tr>


<tr>
<td>set a (secret) minimum price if like:</td>
<td><input type="text" name="minprice"  value="100.0"></td>
</tr>



<tr>
<td>set end Time:</td>
<script language="javascript"  src="./JS/WdatePicker.js"></script>
<td><input class="Wdate" type="text" name="end_time"onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"></td>
</tr>
<tr>
<td><input type="submit" value="Release" style="margin-left:10px; margin-bottom:20px" /></td>

</tr>
</form>

</table>
<%
String user_category = (String)session.getAttribute("user_category");					

if(user_category.equals("customer")){
	out.println("<a href='cuspage.jsp'>reutrn</a>");
}else if(user_category.equals("representative")){
	out.println("<a href='representative.jsp'>reutrn</a>");
}else if(user_category.equals("administration")){
	out.println("<a href='administration.jsp'>reutrn</a>");
}
%>


</body>
</html>
