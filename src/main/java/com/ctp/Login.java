


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
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uemail = request.getParameter("username");
		//String logintype = request.getParameter("logintype");

		String upwd = request.getParameter("password");
		
		HttpSession session = request.getSession();
	
		RequestDispatcher dispatcher = null;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
		PreparedStatement pst = con.prepareStatement("select * from ctp_login where login_id =?  and password = ?");
		pst.setString(1,uemail);
		//pst.setString(2,logintype);
		pst.setString(2,upwd);
		
		
		ResultSet rs = pst.executeQuery();
		dispatcher = request.getRequestDispatcher("login.jsp");
		if(rs.next()) {
			 session.setAttribute("name",rs.getString("login_id"));
			
			 String loginTypeId = rs.getString("login_type_id");
			 
             String redirectUrl = getRedirectUrl(loginTypeId);

             if (redirectUrl != null) {
                 // Login successful, redirect to the appropriate page based on login_type_id
                 //response.sendRedirect(redirectUrl);
            	 dispatcher = request.getRequestDispatcher(redirectUrl);
             } else if("4".equals(loginTypeId)){
            	 
            	   	request.setAttribute("uemail", uemail);
                    RequestDispatcher dispatcher1 = request.getRequestDispatcher("trainer_sch_view.jsp");
                    dispatcher1.forward(request, response);
                    
                 // Login failed due to invalid login_type_id, show an error message
                // response.sendRedirect("login.jsp?error=InvalidLoginType");
            	 
             }
             else {
            	 request.setAttribute("status","match");
             }

	       // Forward the request to the appropriate JSP page
	       // request.getRequestDispatcher(jspPage);
			
			//dispatcher = request.getRequestDispatcher(jspPage);
				
		}
		
		else {
			request.setAttribute("status","failed");
			//dispatcher = request.getRequestDispatcher("login.jsp");
			//request.getRequestDispatcher("login.jsp");
			//dispatcher = request.getRequestDispatcher("login.jsp");
			
		}
		dispatcher.forward(request, response);
		
	}
	
	catch(Exception e) {
		e.printStackTrace();
	}

}
	
	private String getRedirectUrl(String loginTypeId) {
        // Implement your logic here to determine the appropriate redirect URL based on login_type_id
        // For example:
        if ("1".equals(loginTypeId)) {
            return "admin.jsp"; // Redirect to er.jsp if login_type_id is 1
        } else if ("2".equals(loginTypeId)) {
            return "coordinator.jsp"; // Redirect to mr.jsp if login_type_id is 2
        }else if ("3".equals(loginTypeId)) {
            return "manager.jsp"; // Redirect to mr.jsp if login_type_id is 2
        }
        
//        else if ("4".equals(loginTypeId)) {
//         return "trainer.jsp"; // Redirect to mr.jsp if login_type_id is 2
//        }
        
        else {
            return null; // Invalid login_type_id, return null to show an error
        }
    }
}
