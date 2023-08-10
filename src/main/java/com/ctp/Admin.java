package com.ctp;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

//import org.apache.catalina.connector.Request;
//import org.apache.catalina.connector.Request;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/assign")
@MultipartConfig     //server will know that user is sending file type data
public class Admin extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String userinfo = request.getParameter("login_id");
	
		
		String LoginType = request.getParameter("LoginType");
		
		
		
		HttpSession session=request.getSession();
		RequestDispatcher dispatcher = null;
		
		
		try {
			
			
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");

			
			PreparedStatement ps = con.prepareStatement("UPDATE ctp_login SET login_type_id = ? WHERE login_id = ?");
			ps.setString(1, LoginType);
			ps.setString(2, userinfo);
	
			
			
			int i = ps.executeUpdate();
		
			
			//dispatcher = req.getRequestDispatcher("registration.jsp");
			
			dispatcher = request.getRequestDispatcher("admin_form.jsp");
			if(i>0) {
				request.setAttribute("status", "success");
				
				//request.setAttribute("message", "Upload Successful");
				
				//session.setAttribute("msg", "upload successful");
				//request.setAttribute("status","failed");
				
				//response.sendRedirect("admin_form.jsp");   //resp is response
				
				
			}
			else {
				System.out.println("upload failed");
				session.setAttribute("msg", "upload failed");
			//	response.sendRedirect("proposal_view.jsp");   //resp is response
				
			}
			
			dispatcher.forward(request, response);
			
			
		}
		
		catch(Exception e){
			e.printStackTrace();
			
		} 
		
		
	}

	
	

	

}
