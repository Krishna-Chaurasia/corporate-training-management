<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.*" import="javax.sql.*"%>

<%@ page import="java.util.List"%>

<%@ page import="java.sql.*" %>


<%@ page import="java.io.*" %>


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

	<ul class="menu">
		<li><a href="#">Home</a></li>
		<li><a href="#"> Scheduling Management </a>
			<ul class="dropdown">

				<li><a href="coordinator_sch.jsp">Training Schedule</a></li>
				<li><a href="coordinator_sch_view.jsp">View Scheduling</a></li>


			</ul></li>



		<!-- <li><a href="#about">About</a></li>-->
		<!-- 	<li><a href="#contact">Contact</a></li>-->
		<li><a href="logout">Logout</a></li>

		<!-- 	<li ><a href="logout"session.getAttribute("name")e") %></a></li>	  -->

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


		<p align="center">Scheduling
		<p>
		<form method="post" action="scheduling">
		<label for="WO_id">WO_id:</label>
        <select id="WO_id" name="WO_id" >
            <!-- Populate the options here with data from the ctp_work_order table -->
            <option value="" selected disabled>select</option>
            <% 
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false", "root", "mysql");
                Statement st = con.createStatement();
                String query = "SELECT WO_id FROM ctp_work_order";
                ResultSet rs = st.executeQuery(query);
                while (rs.next()) {
                    String WO_id = rs.getString("WO_id");
            %>
                <option value="<%= WO_id %>" ><%= WO_id %></option>
            <% 
                }
                //rs.close();
               // st.close();
               // con.close();
            } catch (Exception e) {
                e.printStackTrace();
                // Handle the error and display an appropriate message to the user.
            }
            %>
        </select>
        
   
   
         <label for="proposal_name">Proposal Name:</label>
            <input type="text" id="proposal_name" name="proposal_name"  readonly>

            <label for="course_name">Course Name:</label>
            <input type="text" id="course_name" name="course_name" readonly>
        
        
       
         <label for="Duration">Duration</label> 
			<input type="text"
				name="Duration" placeholder="Duration" />
				
				  <label for="part">No. of Participants</label> 
			<input type="number"
				name="participants" placeholder="Participants" style="width: 360px; height:49.6px"/>
				
				<label for="from date">Start
				Date</label>
				
				 <input type="date" name="StartDate" placeholder="Start Date" />

			<label for="to date">End Date</label> <input type="date"
				name="EndDate" placeholder="End Date" />
				
				 <label for="location">Location</label>
			<input type="text" name="Location" placeholder="Location" /> <label
				for="Faculty">Faculty</label>
			<!--<input type="text" name="Faculty" placeholder="Faculty" />   -->

			<select id="Facultyid" name="Faculty">
				<option value="" selected disabled>select</option>
				<%
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false",
					"root", "mysql");
					Statement st = con.createStatement();
					String query = "select registration_id,f_name from ctp_registration where email_id IN (SELECT login_id FROM ctp_login WHERE login_type_id = '4')";
					//getting table data 
					ResultSet rs = st.executeQuery(query);

					//to get P_name(proposal name) one by one 

					while (rs.next()) {
				%>
				<option value="<%=rs.getString("registration_id")%>"><%=rs.getString("f_name")%></option>
				<%
				}

				}

				catch (Exception e) {

				}
				
				%>
			</select> <input type="submit" name="submit" value="Submit" />

		</form>
		
        

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>


</body>
</html>