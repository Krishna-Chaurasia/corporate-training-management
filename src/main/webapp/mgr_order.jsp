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
		<li><a href="#"> Proposal Management </a>
			<ul class="dropdown">

				<li><a href="mgr_proposal.jsp">Upload Proposals</a></li>
				<li><a href="mgr_proposal_view.jsp">View Proposals</a></li>
				<li><a href="mgr_order.jsp">Upload Work Order</a></li>
				<li><a href="mgr_orders_view.jsp">View Work Order</a></li>
			</ul></li>



	<!--  	<li><a href="#about">About</a></li>  -->
	<!-- 	<li><a href="#contact">Contact</a></li> -->
		
	    <li><a href="logout">Logout</a></li>   

		<!-- 	<li ><a href="logout"session.getAttribute("name")e") %></a></li>	  -->

	</ul>

	<div class="contact-form">
		



					<%
							String msg = (String) session.getAttribute("msg");
							if (msg != null) {
							%>
							<h4 class="text-center text-success"><%=msg%></h4>
							<%
							session.removeAttribute("msg");
							}
							%>
							
							
		<p align="center">Work Order <p>
		<form method="post" action="WorkOrder" enctype="multipart/form-data">

			<label for="Proposal_Name">Proposal </label> 
		
				
			 <select id="Proposal_Name" name="Proposal_Name">
				 <option value="" selected disabled> Select Proposal </option>
				 <%
				 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "select proposal_id,proposal_name from ctp_proposals";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					//to get P_name(proposal name) one by one 
					
					while(rs.next()){
						%>
						<option value="<%=rs.getString("proposal_id") %>"><%=rs.getString("proposal_name") %></option>
						<% 
					}
					
				}
				 
				 catch(Exception e){
					 
				 }
				 %>
				 
			</select>
				
				<label
				for="Submission Date">WO Submit Date</label> <input type="date"
				name="SubmissionDate" placeholder="Date" />
				
				<label for="WO payment">Payment Status</label>
								<select id="WO payment" name = "payment" >
							         <option value="" selected disabled >Select</option>
							         <option value = "Paid">Paid</option>
							         <option value = "Not Paid">Not Paid</option>
							         
							    </select>
							    
				 <label
				for="Upload file">WO File(pdf, jpg)</label>
				 <input
				type="file" name="UploadProposal" accept=".pdf,.jpg"
				placeholder="Upload Proposal File(pdf,jpg)" multiple />
				
				
				
				 <input
				type="submit" name="submit"  value="Submit" />

		</form>
	</div>
	<!-- JS -->

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">

	<script type="text/javascript">
		var status = document.getElementById("status").value;
		if (status == "success") {
			swal("Congrats", "Work Order Submitted Successfully", "success");
		}
	</script>
	
	
	<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
crossorigin="anonymous"></script>


</body>
</html>