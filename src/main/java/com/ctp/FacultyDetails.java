package com.ctp;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


@WebServlet("/faculty")
/**
 * Servlet implementation class admin
 */
public class FacultyDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//to get some value from user in sign up page
		String FacultyName = request.getParameter("FacultyName");
		String facultyEmail = request.getParameter("facultyEmail");
		String facultyType = request.getParameter("facultyType");
		
		
		Connection con = null;
		
		RequestDispatcher dispatcher = null;
    	
		HttpSession session=request.getSession();
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
			PreparedStatement pst = con.prepareStatement("insert into ctp_faculty(faculty_name,f_email,f_type) values(?,?,?)");
			
			//all the column of details table are in varchar type which is equivalent to String 
			pst.setString(1, FacultyName);
			pst.setString(2, facultyEmail);
			pst.setString(3, facultyType);
			
			int rowcount = pst.executeUpdate();
			// pst.executeUpdate();  :: this tells no. of rows affected and values are inserted to database or not 
			//dispatcher = request.getRequestDispatcher("schedule_view.jsp");
			if(rowcount > 0) {
				session.setAttribute("msg", "upload successful");
				request.setAttribute("status", "success");
				//dispatcher = request.getRequestDispatcher("index.jsp");
				
				response.sendRedirect("schedule_view.jsp");
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
