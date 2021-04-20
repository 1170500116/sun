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
Release interested aution!
<table>



<form  method = "post"  action = "Release_interested_make.jsp">

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
<td><input type="submit" value="Release" style="margin-left:10px; margin-bottom:20px" /></td>

</tr>
</form>

</table>
<a href="javascript:history.back(-1)">reutrn</a>

</body>
</html>
