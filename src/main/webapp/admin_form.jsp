
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
	
	<li><a href="#">Home</a></li>
	 <li > <a href="#"> User Management </a>
        
        <ul class = "dropdown">

        <li><a href = "admin_form.jsp">Assign Role</a></li>
     <!--   <li><a href = "facultyDetails.jsp">Faculty Details</a></li>   --> 
        
        </ul></li>
         
                 <!--   <li ><a href="#about">About</a></li>-->
				<!-- 	<li ><a	href="#contact">Contact</a></li>-->
				 	<li ><a href="logout">Logout</a></li>   
					
    </ul>
	
	
	 <div class="contact-form">
		<!-- proposal summary form -->
					
				
					
					<p align="center" >Assign Role <p>
					
					
					
						<form method="post" action="assign" id="myForm" >
						     
							<label for="Proposal Name">login_id</label>	
						<!-- 	<input type="text" name="ProposalName" placeholder="User data" />	 -->
						   
              <select id="course" name="login_id">
                <option value="" selected disabled> Select Login Id </option>
                <% 	 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "select login_id from ctp_login";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					//to get courses values
					while(rs.next()){
						%>
						<option><%=rs.getString("login_id") %></option>
						<% 
					}	
				}
				 catch(Exception e){
					 
				 } 
                %>
            
            </select>	
            
                    <!-- 							
							<label for="Proposal Name">User Id</label>
							<input type="text" name="id" placeholder="Enter User Id " />									
							
						 -->	
							
							<label for="Proposal Type">Assign Role</label>						
							<select id="ProposalType" name = "LoginType">
							<option value="" selected disabled> Select Login Type </option>
							   <% 	 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "select login_type_id,login_type from ctp_login_type";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					
					//to get courses values
					while(rs.next()){
						String loginTypeId = rs.getString("login_type_id");
						%>
						<option value= "<%=loginTypeId%>"> <%=rs.getString("login_type") %></option>
						<% 
					}	
				}
				 catch(Exception e){
					 
				 } 
                %>      
							          
							</select>
							
							 
								<input type="submit" name="submit" value="Assign" />
							
						</form>
	
						
							</div>
	<!-- JS -->
	
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
<script type = "text/javascript">

var status = document.getElementById("status").value;
if(status=="success"){
	swal("Congrats","Role Assinged Successfully","success");
}

</script>

<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
crossorigin="anonymous"></script>


</body>
</html>