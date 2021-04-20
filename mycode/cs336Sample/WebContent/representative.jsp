<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	var se =document.getElementById("a").options;
 	se.length=0;
	switch(te)
	{ 
	 case "all":
		  var op =new Option("all","all");
		  se.add(op);
	  break;
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
Welcome to BUYME!
<table>
<tr><td>category</td><td>subcategory</td><td>description</td><td>Bid Price order</td></tr>
<tr>


<form  method = "post" action = "search.jsp">
<td>
	<select name="category" size=1 onchange="city(this)" onclick="city(this)">
		<option value="all">all</option>
		<option value="vehicles">vehicles</option>
		<option value="clothing">clothing</option>
		<option value="computers">computers</option>
	</select>
</td>



<td>
	<select name="subcategory" size=1  id="a">
		<option value="all">all</option>		
	</select>
</td>
<td><input type="text" name="description"></td>

<td>
	<select name="order" size=1 >
			<option value="ascending">ascending</option>
		<option value="descending">descending</option>
	</select>
</td>
<td><input type="submit" value="search" /></td>
</form>

</tr>
</table>
<br>
<form  method = "post" action = "Search_question.jsp">	
<td>question key word:<input type="text" name="question" value="all"></td>
<td><input type="submit" value="search" /></td>
</form>

<table>
<form  method = "post" action = "Logout.jsp">	
<td><input type="submit" value="logout" /></td>
</form>

</table>
</body>
