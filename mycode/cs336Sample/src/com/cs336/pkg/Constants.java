package com.cs336.pkg;

import java.io.File;
import java.io.*;
import java.util.*;
import java.sql.*;
public class Constants {
	public static int uid = 0;
	public static int aution_id = 0;
	public static int bid_id = 0;	
	public static int qanda_id = 0;	
	public static int interested_id = 0;	
	
	public static String image_vehicle = System.getProperty("user.dir")+File.separator+"images/vehicle.jpg";
	public static String image_clothing = System.getProperty("user.dir")+File.separator+"images/clothing.jpg";
	public static String image_computer = System.getProperty("user.dir")+File.separator+"images/computer.jpg";
	public static String default_description = "say_something_about_the_goods";
	public static void init() {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		//Create a SQL statement
		Statement stmt;
		try {
			stmt = con.createStatement();
			ResultSet result;
			String sql = "SELECT * FROM user";
			result = stmt.executeQuery(sql);
			while(result.next()){
				if(result.getInt("uid")>uid) {
					Constants.uid = result.getInt("uid");
				}
			
			}
			sql = "SELECT * FROM aution";
			result = stmt.executeQuery(sql);
			while(result.next()){
				if(result.getInt("aution_id")>	Constants.aution_id ) {
					Constants.aution_id = result.getInt("aution_id");
				}
			
			}
			sql = "SELECT * FROM bid";
			result = stmt.executeQuery(sql);
			while(result.next()){
				if(result.getInt("bid_id")>	Constants.bid_id ) {
					Constants.bid_id = result.getInt("bid_id");
				}
			
			}
			sql = "SELECT * FROM qanda";
			result = stmt.executeQuery(sql);
			while(result.next()){
				if(result.getInt("qanda_id")>	Constants.qanda_id ) {
					Constants.qanda_id = result.getInt("qanda_id");
				}
			
			}
			sql = "SELECT * FROM interested";
			result = stmt.executeQuery(sql);
			while(result.next()){
				if(result.getInt("interested_id")>	Constants.interested_id ) {
					Constants.interested_id = result.getInt("interested_id");
				}
			
			}
			Constants.uid ++;
			Constants.aution_id ++;
			Constants.bid_id ++;
			Constants.qanda_id ++;
			Constants.interested_id ++;
			
			sql = "SELECT * FROM user where category='admin'";
			result = stmt.executeQuery(sql);
			if(!result.next()) {
				String uname = "admin";
				String password = "a";
				String email = "a";
				String phone = "a";
				String category = "admin";

				//Make an insert statement for the bars table:
				String insert = "INSERT INTO user(uid,uname, password, email, phone,category)" + "VALUES (?,?, ?, ?, ?,?)";
				//Create a Prepared SQL statement allowing you to introduce the parameters of the query
				PreparedStatement ps = con.prepareStatement(insert);
				ps.setInt(1, Constants.uid++);
				ps.setString(2, uname);
				ps.setString(3, password);
				ps.setString(4, email);
				ps.setString(5, phone);
				ps.setString(6, category);
				ps.executeUpdate();
				
				for(int i = 0;i<3;i++) {
					 uname = "rep"+i;
					 category = "representative";
					 ps.setInt(1, Constants.uid++);
					ps.setString(2, uname);
					ps.setString(3, password);
					ps.setString(4, email);
					ps.setString(5, phone);
					ps.setString(6, category);
					ps.executeUpdate();
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
