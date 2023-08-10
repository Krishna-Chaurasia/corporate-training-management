	

<%@page import="com.ctp.DbConnect"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.*" import="javax.sql.*"%>

<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<link rel="stylesheet" href="style1.css">
<link rel="stylesheet" href="propoStyle.css">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">


<body>
<input type = "hidden" id= "status" value="<%= request.getAttribute("status")%>">
	<ul class="menu">
	
	<li><a href="">Home</a></li>
	 <li > <a href="#"> Proposal Management </a>
        
        <ul class = "dropdown">

        <li><a href = "mgr_proposal.jsp">Upload Proposals</a></li>
        <li><a href = "mgr_proposal_view.jsp">View Proposal</a></li>
       <li><a href = "mgr_order.jsp">Upload Work Order</a></li>
        <li><a href = "mgr_orders_view.jsp">View Work Order</a></li>
        
        </ul></li>
         
                 <!--   <li ><a href="#about">About</a></li>  -->
				<!--	<li ><a	href="#contact">Contact</a></li>   -->
				 	<li ><a href="logout">Logout</a></li>  
					
    </ul>
	
	
	 <div class="contact-form">
		<!-- proposal summary form -->
					
							<%	   
							String msg = (String) session.getAttribute("msg");
							if (msg != null) {
							%>
							<h4 class="text-center text-success"><%=msg%></h4>
							<%
							session.removeAttribute("msg");
							}
							%>
					
					<p align="center" >Proposal Summary<p>
					
						<form method="post" action="proposal_summary" enctype="multipart/form-data">
						     
							<label for="Proposal Name">Proposal Name</label>
							<input type="text" name="ProposalName" placeholder="Proposal Name" />									
							
							<label for="Proposal Type">Proposal Type </label>
							<select id="Proposal Type" name = "ProposalType" >
							         <option value="" selected disabled>Select </option>
                <% 	 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "select proposal_type_id,proposal_type from ctp_proposal_type";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					//to get courses values
					while(rs.next()){
						%>
						<option value="<%=rs.getString("proposal_type_id") %>"><%=rs.getString("proposal_type") %></option>
						<% 
					}	
				}
				 catch(Exception e){
					 
				 } 
                %>
							</select>
							
						
								<label for="Proposal For">Proposal For</label>
								<input type="text" name="ProposalFor" placeholder="Proposal For" />
								
								<label for="Submission Date">Submission Date</label>
								<input type="date" name="SubmissionDate"  placeholder="Submission Date" />
						
								<label for="Courses">Course Courses</label>
								<!-- <input type="text" name="Courses" placeholder="Courses" />  -->
								<select id="Courses" name = "Courses" > 
							         <option value="" selected disabled >Select Courses</option>
                <% 	 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "select course_id,course_name from ctp_courses";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					//to get courses values
					while(rs.next()){
						%>
						<option value="<%=rs.getString("course_id") %>"><%=rs.getString("course_name") %></option>
						<% 
					}	
				}
				 catch(Exception e){
					 
				 } 
                %>
							</select>
							
								
								<label for="Submission Date">Costing</label>
								<br>
								<input type="number" name="Costing" placeholder="Costing(in Rs.)" style="width: 360px; height:49.6px" />
									<br>
									
								<label for="Status">Status</label>
								<!-- <input type="text" name="Status"  placeholder="Status" />  -->
								
								<select id="Status" name = "Status" >
							        <option value="" selected disabled >Select </option>
							         <option value = "Submitted">Submitted</option>
							         <option value = "In Process">In Process</option>
							         
							    </select>
							     
							<br>
							
								<label for="Delivery Date">Expected Delivery Date</label>
								<br>
								<input type="date" name="ExpectedDeliveryDate"  placeholder="Expected Delivery Date" />

								<label for="Final Status">Final Status</label>
								<select id="Final Status" name = "FinalStatus" >
							         <option value="" selected disabled >Select</option>
							         <option value = "WO Received">WO Received</option>
							         <option value = "WO Pending">WO Pending</option>
							         
							    </select>
							     
							<!-- 	<input type="text" name="FinalStatus"placeholder="Final Status" />    -->

							   <label for="Executed By">Executed By Centre Id</label>
							   <select id="Executed By" name = "ExecutedBy" >
							         <option value = "Proposal Type" selected disabled>Executer By</option>
							             <% 	 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "select centre_name from ctp_centres";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					//to get courses values
					while(rs.next()){
						%>
						<option><%=rs.getString("centre_name") %></option>
						<% 
					}	
				}
				 catch(Exception e){
					 
				 } 
                %> 
							   </select>								
						
								<label for="Upload file">Upload Proposal File(pdf, jpg)</label>
								<input type="file" name="UploadProposal"   accept=".pdf,.jpg"
								    placeholder="Upload Proposal File(pdf,jpg)"  multiple/>
								
								<input type="submit" name="submit" value="Submit" />
							
						</form>	</div>
	<!-- JS -->
	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type = "text/javascript">

var status = document.getElementById("status").value;
if(status=="success"){
	swal("Congrats","Proposal Submitted Successfully","success");
}
</script>
<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
crossorigin="anonymous"></script>


</body>
</html>