package com.ctp;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class RegistrationServlet
 */

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//to get some value from user in sign up page
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		
		String upwd = request.getParameter("pass");
		String con_pwd = request.getParameter("con_pass");
		String uemail = request.getParameter("email");
		String umobile = request.getParameter("contact");
		//String login_type = request.getParameter("LoginType");
		
		Connection con = null;
		
		RequestDispatcher dispatcher = null;
    	
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
			PreparedStatement pst = con.prepareStatement("insert into ctp_registration(f_name,l_name,email_id,mobile) values(?,?,?,?)");
			
			PreparedStatement ps = con.prepareStatement("insert into ctp_login(login_id,password) values(?,?)");
			
			//all the column of details table are in varchar type which is equivalent to String 
			pst.setString(1, fname);
			pst.setString(2, lname);
			pst.setString(3, uemail);
			pst.setString(4, umobile);
			
			ps.setString(1, uemail);
			
			if(upwd.equals(con_pwd)) {
				ps.setString(2, upwd);
				}
				
				else {
					System.out.println("password didn't matched");
					request.setAttribute("status", "Password Not Matched");
					dispatcher = request.getRequestDispatcher("registration.jsp");
				}
			
			
			int rowcount = pst.executeUpdate();
			int rowcount1 = ps.executeUpdate();
			// pst.executeUpdate();  :: this tells no. of rows affected and values are inserted to database or not 
			dispatcher = request.getRequestDispatcher("registration.jsp");
			if(rowcount > 0 && rowcount1>0) {
				request.setAttribute("status", "success");
				
//				ResultSet generatedKeys = pst.getGeneratedKeys();
//                if (generatedKeys.next()) {
//                    long generatedId = generatedKeys.getLong(1);
//                    response.sendRedirect("registration.jsp?generatedId=" + generatedId);
//                }
//				
				dispatcher = request.getRequestDispatcher("login.jsp");
				
			}
			
			else {
				request.setAttribute("status", "failed");
			}
			
			dispatcher.forward(request, response);
			
		}
		
		catch(Exception e){
			e.printStackTrace();
			
		} finally {
			try {
				con.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		 
	}

}
