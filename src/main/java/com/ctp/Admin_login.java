package com.ctp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/AdminLogin")
public class Admin_login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uemail = request.getParameter("username");
	//	String type_id = request.getParameter("type_id");
		String upwd = request.getParameter("password");
		
		HttpSession session = request.getSession();
	
		RequestDispatcher dispatcher = null;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
		PreparedStatement pst = con.prepareStatement("select * from ctp_login where login_id =? and password= ?");
		pst.setString(1,uemail);
		//pst.setString(2,type_id);
		pst.setString(2,upwd);
		
		ResultSet rs = pst.executeQuery();
		if(rs.next()) {
			//session.setAttribute("name",rs.getString("f_name"));
			dispatcher = request.getRequestDispatcher("admin_form.jsp");
			
		}
		
		else {
			request.setAttribute("status","failed");
			dispatcher = request.getRequestDispatcher("admin_login.jsp");
			
		}
		dispatcher.forward(request, response);
		
	}
	
	catch(Exception e) {
		e.printStackTrace();
	}

}
}
