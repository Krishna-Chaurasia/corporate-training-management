package com.ctp;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class WorkOrder
 * @param <DataItem>
 */
@WebServlet("/WorkOrder")
@MultipartConfig 
public class WorkOrder<DataItem> extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String ProposalName = req.getParameter("Proposal_Name");
		
		String SubmissionDate = req.getParameter("SubmissionDate");
		
		Part p = req.getPart("UploadProposal");
		String UploadOrder = p.getSubmittedFileName();
		
		String payment = req.getParameter("payment");
		
		Connection con = null;
		HttpSession session=req.getSession();
		RequestDispatcher dispatcher = null;
		String path=null;
		
		
		try {
			
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
			
			

			
			PreparedStatement ps = con.prepareStatement("insert into ctp_work_order(Proposal_id, WO_Submit_date, WO_payment_status, WO_file, WO_file_location) values(?,?,?,?,?)");
			ps.setString(1,ProposalName );
			
			ps.setString(2,SubmissionDate );
			ps.setString(3,payment );
			ps.setString(4,UploadOrder );
			
			String fileLocation = "WorkOrder/" + UploadOrder;
            ps.setString(5, fileLocation);
			
			int i = ps.executeUpdate();
		
			
			
			if(i>0) {
				
				 path = getServletContext().getRealPath("")+"WorkOrder";
				File file=new File(path);
				
				p.write(path+File.separator+UploadOrder);
				
				session.setAttribute("msg", "upload successful");
				req.setAttribute("status","failed");
				
				resp.sendRedirect("mgr_orders_view.jsp");   //resp is response
				
				
			}
			else {
				System.out.println("upload failed");
				session.setAttribute("msg", "upload failed");
				resp.sendRedirect("mgr_orders_view.jsp");   //resp is response
				
			}
			
			//dispatcher.forward(req, resp);
			
			
		}
		
		catch(Exception e){
			e.printStackTrace();
			
		} 
		
	    System.out.println(UploadOrder  + " " );
	    
	    System.out.println(path);

	}

}
