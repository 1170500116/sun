<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>

Here the searched questions!
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Get parameters from the HTML form at the index.jsp
	
		String question = request.getParameter("question");
		String sql = "SELECT * FROM qanda ";
		ResultSet result = stmt.executeQuery(sql);
		
		
						
		
		String buffer="";
		buffer+="<table>\n";
		while(result.next()){			
			String _question = result.getString("question");
			String ans = result.getString("ans");
			int  qanda_id = result.getInt("qanda_id");
			int  wen_id = result.getInt("wen_id");
			int  da_id = result.getInt("da_id");
			
			String wen_name=null;
			String da_name=null;
			
			String sql_ = "SELECT * FROM user WHERE uid = " + wen_id;
			Statement stmt1 = con.createStatement();
			ResultSet  result_ = stmt1.executeQuery(sql_);	
			if(result_.next()){
				System.out.println("???????????????!!!!!!!111");
				wen_name = result_.getString("uname");		
			}
			if(da_id!=-1){
				 sql_ = "SELECT * FROM user WHERE uid = " + da_id;
				 result_ = stmt1.executeQuery(sql_);
				 if(result_.next()){
					 da_name = result_.getString("uname");		
				}
			}
			if(question.equals("all")||_question.indexOf(question)!=-1){
				 buffer+=	String.format(						 
						"<tr><td>\n"+
						"<br>"+		
						"from:%s"+
						"<br>"+	
						"question:%s "+
						"<br>",	
						wen_name,_question);  
				 if(da_name!=null&&!da_name.equals("")){
					 buffer+=	String.format(
								"anser:%s"+
								"<br>"+	
								"ans:%s "+
								"<br>"+
								"------------------------------------------------------------\n"+
								"<br>"+	
								"</td></tr>\n",
								da_name,ans);  
					 System.out.println("hre");
				 }else{
						String user_category = (String)session.getAttribute("user_category");					
						 System.out.println("aaa");
						if(user_category.equals("customer")){
							buffer+="ans:null";
						}else if(user_category.equals("representative")){
							buffer+=String.format("<form  method = 'post' action = 'ans_questions.jsp?qanda_id=%d'>"+
							"ans:<input type='text' name='ans' >"+
							"<input type='submit' value='ans question' /></form></td></tr>\n",qanda_id);
						}
						
				 }
			}
			
			
		}
		buffer+="</table>\n";
		out.println(buffer);
	
		
		//close the connection.
		con.close();
		out.print("Search succeeded");
	} catch (Exception ex) {
		out.print(ex);
		out.print("Search failed");
	}
	
%>
<br>
<a href="javascript:history.back(-1)">reutrn</a>
</body>
</html>