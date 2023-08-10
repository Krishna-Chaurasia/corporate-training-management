<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@page import="com.ctp.DbConnect"%>

<%@page import="java.sql.*" import="javax.sql.*"%>

<%@ page import="java.util.List"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="propoStyle.css">

<link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">

<script type="text/javascript"  src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script type="text/javascript"  src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>

<script>
// when the document is ready

$( document ).ready(function(){
	
	$("#dataTable").dataTable();
});
</script>

<style>
th,td{
border-bottom:1px solid;
border-right:1px solid;	
}
th{

border-bottom:3px solid;

}

table,th,td{
border-collapse:collapse;
padding:10px;
}

table{
border:1px solid;	
}
</style>


<body>


<ul class="menu">
	
	<li><a href="#">Home</a></li>
	 <li > <a href="#"> Scheduling Management </a>
        
        <ul class = "dropdown">

		
        <li><a href = "coordinator_sch.jsp">Training Schedule</a></li>
        <li><a href = "coordinator_sch_view.jsp">View Scheduling </a></li>
      
        </ul></li>
         
                 <!--    <li ><a href="#about">About</a></li>-->
				<!-- 	<li ><a	href="#contact">Contact</a></li>-->
					<li ><a href="logout">Logout</a></li>   
					
    </ul>
	
<br>

<h3>Scheduled Summary</h3>

<br>

<form id="filterForm">
        <label for="filter">View By:</label>
        <select id="filter" name="filter" onchange="showFilterOptions()">
            <option value="all" selected disabled>All Data</option>
            <option value="date">Start Date</option>
            <option value="delivery_date">End Date</option>
            <option value="course">Course</option>
            <option value="location">Location</option>
            
        </select>

        <div id="dateFilter" style="display: none;">
            <label for="from_date">From Date:</label>
            <input type="date" id="from_date" name="from_date">
            <label for="to_date">To Date:</label>
            <input type="date" id="to_date" name="to_date">
        </div>
        
        <div id="deliveryDateFilter" style="display: none;">
            <label for="from_delivery_date">End Date Between:</label>
            <input type="date" id="from_delivery_date" name="from_delivery_date">
            <label for="to_delivery_date">and :</label>
            <input type="date" id="to_delivery_date" name="to_delivery_date">
        </div>

        <div id="courseFilter" style="display: none;">
            <label for="course">Select Course:</label>
            <select id="course" name="course">
                <option value="">Select</option>
                <% 	 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "SELECT * from ctp_courses";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					//to get courses values
					while(rs.next()){
						%>
						<option><%=rs.getString("Course_name") %></option>
						<% 
					}	
				}
				 catch(Exception e){
					 
				 } 
                %>
                
           
            </select>
        </div>

        
        <div id="locationFilter" style="display: none;">
            <label for="location">Select Location:</label>
            <select id="location" name="location">
                <option value="" selected disabled>Select</option>
                
                 <% 	 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "select location from ctp_scheduling";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					//to get courses values
					while(rs.next()){
						%>
						<option><%=rs.getString("location") %></option>
						<% 
					}	
				}
				 catch(Exception e){
					 
				 } 
                %>
                
            </select>
        </div>
        
        <input type="button" value="View Data" onclick="applyFilter()">
        <button type="button" onclick="resetFilter()">Reset Data</button>
    </form>
   
   
<table  id="dataTable"  class="table mt-4">
			<thead>
				<tr>
					<th scope="col">Schedule ID</th>
					
					<th scope="col">Proposal Name</th>
					<th scope="col">Courses</th>
					<th scope="col">Duration</th>
					<th scope="col">No. of Participants</th>
					<th scope="col">Start Date</th>
					<th scope="col">End Date</th>
					<th scope="col">Location</th>
					<th scope="col">Faculty</th>
				</tr>
			</thead>
			<tbody>
				<%
				Class.forName("com.mysql.cj.jdbc.Driver");
				 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false",
						"root", "mysql");
				PreparedStatement ps = conn.prepareStatement("SELECT ctp_scheduling.*, ctp_registration.registration_id, ctp_registration.f_name FROM ctp_scheduling INNER JOIN ctp_registration ON ctp_scheduling.faculty_id = ctp_registration.registration_id");

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
				%>
				<tr>
					
				    <td><%=rs.getString("schedule_id")%></td>  
				   
				    <td><%=rs.getString("proposal_name")%></td>  
				    <td><%=rs.getString("course_name")%></td>  
					
					<td><%=rs.getString("duration") %></td>
					<td><%=rs.getString("participants") %></td>
					<td><%=rs.getString("Start_date") %></td>
					<td><%=rs.getString("End_date") %></td>
					<td><%=rs.getString("location") %></td>
					<td><%=rs.getString("f_name") %></td>
					
					
				</tr>
				<%
				}
				%>

			</tbody>
		</table>
		
		<script>
        function showFilterOptions() {
        	
            const filterOption = document.getElementById("filter").value;
            const dateFilterDiv = document.getElementById("dateFilter");
            const courseFilterDiv = document.getElementById("courseFilter");
            const locationFilterDiv = document.getElementById("locationFilter");
            const deliveryDateFilterDiv = document.getElementById("deliveryDateFilter");
           
            dateFilterDiv.style.display = "none";
            courseFilterDiv.style.display = "none";
            locationFilterDiv.style.display = "none";
            deliveryDateFilterDiv.style.display="none";
            
            switch (filterOption) {
                case "date":
                    dateFilterDiv.style.display = "block";
                    break;
                case "course":
                    courseFilterDiv.style.display = "block";
                    break;
                case "location":
                	locationFilterDiv.style.display = "block";
                    break;
                case "delivery_date":
                    deliveryDateFilterDiv.style.display = "block";
                    break;
                
                default:
                    // Show all data option, no additional filters needed
                    break;
            }
        }

        function applyFilter() {
            const filterOption = document.getElementById("filter").value;
            const fromDate = document.getElementById("from_date").value;
            const toDate = document.getElementById("to_date").value;
            const courseFilter = document.getElementById("course").value;
            const locationFilter = document.getElementById("location").value;
            
            const fromDeliveryDate = document.getElementById("from_delivery_date").value;
            const toDeliveryDate = document.getElementById("to_delivery_date").value;
           
            const rows = document.querySelectorAll("#dataTable tbody tr");
            rows.forEach(row => {
                const dateCell = row.querySelector("td:nth-child(6)");
                const date = dateCell.textContent;
                const courseCell = row.querySelector("td:nth-child(4)");
                const courseValue = courseCell.textContent;
                const locationCell = row.querySelector("td:nth-child(8)");
                const locationValue = locationCell.textContent;
                const deliveryDateCell = row.querySelector("td:nth-child(7)");
                const deliveryDate = deliveryDateCell.textContent;
                
                const dateMatch = (filterOption === "all" || filterOption === "course" || filterOption === "location" || filterOption === "delivery_date")
                    || (new Date(date) >= new Date(fromDate) && new Date(date) <= new Date(toDate));
                
                const courseMatch = (filterOption === "all" || filterOption === "date" || filterOption === "location" || filterOption === "delivery_date" )
                    || (courseFilter === '' || courseValue === courseFilter);
                
                const locationMatch = (filterOption === "all" || filterOption === "date" || filterOption === "course" || filterOption === "delivery_date")
                    || (locationFilter === '' || locationValue === locationFilter);
                
                const deliveryDateMatch = (filterOption === "all" || filterOption === "date" || filterOption === "course" || filterOption === "location")
                || (new Date(deliveryDate) >= new Date(fromDeliveryDate) && new Date(deliveryDate) <= new Date(toDeliveryDate));
                
                
                row.style.display = (dateMatch && courseMatch && locationMatch && deliveryDateMatch ) ? "table-row" : "none";
            });
        }

        function resetFilter() {
            const rows = document.querySelectorAll("#dataTable tbody tr");
            rows.forEach(row => {
                row.style.display = "table-row";
            });

            document.getElementById("filter").value = "all";
            document.getElementById("from_date").value = '';
            document.getElementById("to_date").value = '';
            document.getElementById("course").value = '';
            document.getElementById("location").value = '';
            document.getElementById("from_delivery_date").value = '';
            document.getElementById("to_delivery_date").value = '';
           

            showFilterOptions(); // Hide all filter options divs again
        }
    </script>
		
		<!-- 
		
		<br><br>
		<br>
     
     <div  >  <a href = "proposal_view.jsp"  style="font-size:35px;color:#964B00;">View Proposal Summary Records</a> </div>
     <br><br>

<div   >  <a href = "orders_view.jsp"  style="font-size:35px;color:#964B00;">View Work Order Records</a> </div>
   
    -->
    
</body>
</html>