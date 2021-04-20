<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
Release a bid!
<% 
String aution_id=request.getParameter("aution_id");

System.out.println(aution_id);
%>

<table>
<form  method = "post"  action = "Release_bid_make.jsp?aution_id=<%=request.getParameter("aution_id") %>">

<tr>
<td>set  an original price:</td>
<td><input type="text" name="original_price" value="120.0"></td>
</tr>


<tr>
<td>set an increment for the bid:</td>
<td><input type="text" name="increment" value="10.0"></td>
</tr>


<tr>
<td>set a max price:</td>
<td><input type="text" name="maxprice"  value="150.0"></td>
</tr>


<tr>
<td><input type="submit" value="Release" style="margin-left:10px; margin-bottom:20px" /></td>
</tr>

</form>

</table>
</body>
</html>
