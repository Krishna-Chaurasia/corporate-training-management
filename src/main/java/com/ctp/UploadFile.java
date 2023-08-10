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

@WebServlet("/proposal_summary")
@MultipartConfig     //server will know that user is sending file type data
public class UploadFile extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String ProposalName = req.getParameter("ProposalName");
		//String ProposalType = req.getParameter("ProposalType");
		
		int ProposalType = Integer.valueOf(req.getParameter("ProposalType"));
		
		String ProposalFor = req.getParameter("ProposalFor");
		String SubmissionDate = req.getParameter("SubmissionDate");
		//String Courses = req.getParameter("Courses");
		
		int Courses = Integer.valueOf(req.getParameter("Courses"));
		
		float Costing = Float.valueOf(req.getParameter("Costing"));
		
		
		//String Costing = req.getParameter("Costing");
		String Status = req.getParameter("Status");
		String ExpectedDeliveryDate = req.getParameter("ExpectedDeliveryDate");
		
		
		String FinalStatus = req.getParameter("FinalStatus");
		String ExecutedBy = req.getParameter("ExecutedBy");
		
		
		Part p = req.getPart("UploadProposal");
		String UploadProposal = p.getSubmittedFileName();
		
		
		
		HttpSession session=req.getSession();
		//RequestDispatcher dispatcher = null;
		String path=null;
		try {
			
			
			Connection conn=DbConnect.getConn();

			
			PreparedStatement ps = conn.prepareStatement("insert into ctp_proposals(proposal_name, proposal_type_id, proposal_for, proposal_submission_dt, course_id, costing, status, Exp_delivery_date, final_status, executed_by_centre_id, proposal_file,proposal_file_location) values(?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1,ProposalName );
			
			ps.setInt(2,ProposalType );
			
			ps.setString(3,ProposalFor );
			ps.setString(4,SubmissionDate );
			
			ps.setInt(5,Courses );
			ps.setFloat(6,Costing );	
			
			ps.setString(7,Status);
			ps.setString(8,ExpectedDeliveryDate );
			ps.setString(9,FinalStatus);
			ps.setString(10,ExecutedBy );
			ps.setString(11,UploadProposal );
			
			
			 String fileLocation = "proposal/" + UploadProposal;
	            ps.setString(12, fileLocation);
			
			int i = ps.executeUpdate();
		
			
			//dispatcher = req.getRequestDispatcher("registration.jsp");
			
			
			if(i>0) {
				
				 path = getServletContext().getRealPath("")+"proposal";
				File file=new File(path);
				
				p.write(path+File.separator+UploadProposal);
				
				session.setAttribute("msg", "upload successful");
				req.setAttribute("status","failed");
				
				resp.sendRedirect("mgr_proposal_view.jsp");   //resp is response
				
				
			}
			else {
				System.out.println("upload failed");
				session.setAttribute("msg", "upload failed");
				resp.sendRedirect("mgr_proposal_view.jsp");   //resp is response
				
			}
			
			//dispatcher.forward(req, resp);
			
			
		}
		
		catch(Exception e){
			e.printStackTrace();
			
		} 
		
	    System.out.println(UploadProposal  + " " );
	    
	    System.out.println(path);
	    
		
	}

	
	

	

}
