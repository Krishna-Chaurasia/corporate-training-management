package com.ctp;

import java.io.IOException;
import java.io.PrintWriter;
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
 * Servlet implementation class Scheduling
 */

@WebServlet("/scheduling")
public class Scheduling extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int woId = Integer.parseInt(req.getParameter("WO_id"));
		 int proposalId = 0;   // Fetch proposal_id based on selectedWOId
	        String proposalName = ""; // Fetch proposal_name based on selectedWOId
	        int courseId = 0;     // Fetch course_id based on selectedWOId
	        String courseName = ""; 
	        //String proposalName = null; // Set to null initially
	        //String courseName = null; 
		String Duration = req.getParameter("Duration");
		//String participants = req.getParameter("participants");
		int participants = Integer.parseInt(req.getParameter("participants"));

		
		String Sdate = req.getParameter("StartDate");
		String Edate = req.getParameter("EndDate");
		String Location = req.getParameter("Location");
		//String Faculty = req.getParameter("Faculty");
		int Faculty = Integer.parseInt(req.getParameter("Faculty"));
		

		HttpSession session=req.getSession();
		RequestDispatcher dispatcher = null;
		String path=null;
		try {
			
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false", "root",
			"mysql");
			
			String query = "SELECT proposals.proposal_id, proposals.proposal_name, courses.course_id, courses.course_name "
                    + "FROM ctp_proposals AS proposals "
                    + "JOIN ctp_courses AS courses ON proposals.course_id = courses.course_id "
                    + "WHERE proposals.proposal_id IN (SELECT proposal_id FROM ctp_work_order WHERE WO_id = ?)";
       PreparedStatement pst = con.prepareStatement(query);
       pst.setInt(1, woId);
       ResultSet rs = pst.executeQuery();
       if (rs.next()) {
           proposalId = rs.getInt("proposal_id");
           proposalName = rs.getString("proposal_name");
           courseId = rs.getInt("course_id");
           courseName = rs.getString("course_name");
           
//           req.setAttribute("WO_id", woId);
//           RequestDispatcher dispatcher1 = req.getRequestDispatcher("coordinator_sch.jsp");
//           dispatcher1.forward(req, resp);
         

//           HttpSession session1 = req.getSession();
//           session1.setAttribute("WO_id", woId);
//           session1.setAttribute("proposal_name", proposalName);
//           session1.setAttribute("course_name", courseName);
//         
//          resp.sendRedirect("coordinator_sch.jsp");
//             
     
                    
       }
       
			
			PreparedStatement ps = con.prepareStatement("insert into ctp_scheduling(WO_id, proposal_id, proposal_name,  course_id, course_name, duration, participants, Start_date, End_date, location, faculty_id) values(?,?,?,?,?,?,?,?,?,?,?)");
			
			ps.setInt(1,woId );
			ps.setInt(2,proposalId );
			ps.setString(3,proposalName );
			ps.setInt(4,courseId );
			ps.setString(5,courseName );
			ps.setString(6,Duration );
			ps.setInt(7,participants );
			
			ps.setString(8,Sdate );
			ps.setString(9,Edate );
			ps.setString(10,Location );
			ps.setInt(11,Faculty );	
			
			int i = ps.executeUpdate();
		
			
			//dispatcher = req.getRequestDispatcher("registration.jsp");
			
			if(i>0) {
				
				
				
				session.setAttribute("msg", "Scheduled Successful");
				//req.setAttribute("status","failed");
				
				resp.sendRedirect("coordinator_sch_view.jsp");   //resp is response
				
				
			}
			else {
				System.out.println("upload failed");
				session.setAttribute("msg", "upload failed");
				resp.sendRedirect("coordinator_sch_view.jsp");   //resp is response
				
			}
			
			//dispatcher.forward(req, resp);	
			
		}
		
		catch(Exception e){
			e.printStackTrace();
			
		} 
		
	}

}
