

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

<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>

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
	
	<li><a href="">Home</a></li>
	 <li > <a href="#"> Proposal Management </a>
        
        <ul class = "dropdown">

        <li><a href = "mgr_proposal.jsp">Upload Proposals</a></li>
        <li><a href = "mgr_proposal_view.jsp">View Proposals</a></li>
       <li><a href = "mgr_order.jsp">Upload Work Order</a></li>
        <li><a href = "mgr_order_view.jsp">View Work Order</a></li>
        
        </ul></li>
         
                  <!--  <li ><a href="#about">About</a></li> -->
				<!--	<li ><a	href="#contact">Contact</a></li> -->
				 	<li ><a href="logout">Logout</a></li> 
					
    </ul>
	
<br>
   
   <h3>Proposal Summary</h3>
   
   <br>
   
  <form id="filterForm">
        <label for="filter">View By:</label>
        <select id="filter" name="filter" onchange="showFilterOptions()">
            <option value="all" selected disabled>All Data</option>
            <option value="date">Submission Date</option>
            <option value="course">Course</option>
            <option value="delivery_date">Delivery Date</option>
            <option value="stat">Status</option>
            <option value="status">Final Status</option>
            <option value="cost">Cost</option>
        </select>

        <div id="dateFilter" style="display: none;">
            <label for="from_date">From Date:</label>
            <input type="date" id="from_date" name="from_date">
            <label for="to_date">To Date:</label>
            <input type="date" id="to_date" name="to_date">
        </div>

        <div id="courseFilter" style="display: none;">
            <label for="course">Select Course:</label>
            <select id="course" name="course">
                <option value="" selected disabled>Select</option>
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
						<option><%=rs.getString("course_name") %></option>
						<% 
					}	
				}
				 catch(Exception e){
					 
				 } 
                %>
            
            </select>
        </div>

        <div id="deliveryDateFilter" style="display: none;">
            <label for="from_delivery_date">From Delivery Date:</label>
            <input type="date" id="from_delivery_date" name="from_delivery_date">
            <label for="to_delivery_date">To Delivery Date:</label>
            <input type="date" id="to_delivery_date" name="to_delivery_date">
        </div>

        <div id="statusFilter" style="display: none;">
            <label for="status">Select Status:</label>
            <select id="status" name="status">
                <option value=""  selected disabled>Select</option>
                
              
                <option value="WO Received">WO Received</option>
                <option value="WO Pending">WO Pending</option>
            </select>
        </div>
        
        <div id="statFilter" style="display: none;">
            <label for="stat">Select Status:</label>
            <select id="stat" name="stat">
                <option value=""  selected disabled>Select</option>
                
                <option value="Submitted">Submitted</option>
                <option value="In Process">In Process</option>
          
            </select>
        </div>

        <div id="costFilter" style="display: none;">
            <label for="min_cost">Minimum Cost:</label>
            <input type="number" id="min_cost" name="min_cost">
            <label for="max_cost">Maximum Cost:</label>
            <input type="number" id="max_cost" name="max_cost">
        </div>

        <input type="button" value="View Data" onclick="applyFilter()">
        <button type="button" onclick="resetFilter()">Reset Data</button>
    </form>
   
<table class="table mt-4" id = "dataTable">
			<thead  >
				<tr  >
					<th scope="col">Proposal Id</th>
					<th scope="col">Proposal Name</th>
					<th scope="col">Proposal Type</th> 
					<th scope="col">Proposal For</th>
					<th scope="col">Submission Date</th>
					<th scope="col">Courses</th>
					<th scope="col">Courses Duration</th>
					<th scope="col">Costing</th>
					<th scope="col">Status</th>
					<th scope="col">Delivery Date</th>
					<th scope="col">Final Status</th>
					<th scope="col">Executed By</th>
					<th scope="col">Proposal file</th>
					<th scope="col">Uploaded File</th>
					
				</tr>
			</thead>
			
			<tbody >
				<%
				Connection conn = DbConnect.getConn();
				PreparedStatement ps = conn.prepareStatement(" SELECT  ctp_proposals.*,  ctp_proposal_type.proposal_type,  ctp_courses.course_name,  ctp_courses.course_duration	FROM     ctp_proposals INNER JOIN     ctp_proposal_type ON ctp_proposals.proposal_type_id = ctp_proposal_type.proposal_type_id	INNER JOIN   ctp_courses ON ctp_proposals.course_id = ctp_courses.course_id");

				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
				%>
				<tr>
				
				
				
				 <td ><%=rs.getString("proposal_id") %></td> 		
					<td ><%=rs.getString("proposal_name") %></td> 
					<td><%= rs.getString("proposal_type") %></td>
					<td ><%=rs.getString("proposal_for") %></td> 
					<td><%=rs.getString("proposal_submission_dt") %></td> 
					<td><%= rs.getString("course_name") %></td>
					 <td><%= rs.getString("course_duration") %></td>
					<td><%=rs.getString("Costing") %></td> 
					<td><%=rs.getString("Status") %></td> 
					<td><%=rs.getString("Exp_delivery_date") %></td> 
					<td><%=rs.getString("Final_Status") %></td> 
					<td><%=rs.getString("Executed_by_centre_id") %></td> 
					<td><%=rs.getString("proposal_file") %></td> 
					
					<td>
                    <a href= "<%= rs.getString("proposal_file_location") %>" target="_blank">View File</a>
                </td>
                
              
                
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
            const deliveryDateFilterDiv = document.getElementById("deliveryDateFilter");
            const statusFilterDiv = document.getElementById("statusFilter");
            const statFilterDiv = document.getElementById("statFilter");
            const costFilterDiv = document.getElementById("costFilter");

            dateFilterDiv.style.display = "none";
            courseFilterDiv.style.display = "none";
            deliveryDateFilterDiv.style.display = "none";
            statFilterDiv.style.display = "none";
            statusFilterDiv.style.display = "none";
            costFilterDiv.style.display = "none";

            switch (filterOption) {
                case "date":
                    dateFilterDiv.style.display = "block";
                    break;
                case "course":
                    courseFilterDiv.style.display = "block";
                    break;
                case "delivery_date":
                    deliveryDateFilterDiv.style.display = "block";
                    break;
                case "status":
                    statusFilterDiv.style.display = "block";
                    break;
                case "cost":
                    costFilterDiv.style.display = "block";
                    break;
                case "stat":
                	statFilterDiv.style.display = "block";
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
            const fromDeliveryDate = document.getElementById("from_delivery_date").value;
            const toDeliveryDate = document.getElementById("to_delivery_date").value;
            const statusFilter = document.getElementById("status").value;
            const statFilter = document.getElementById("stat").value;
            const minCost = document.getElementById("min_cost").value;
            const maxCost = document.getElementById("max_cost").value;

            const rows = document.querySelectorAll("#dataTable tbody tr");
            rows.forEach(row => {
                const dateCell = row.querySelector("td:nth-child(5)");
                const date = dateCell.textContent;
                const courseCell = row.querySelector("td:nth-child(6)");
                const courseValue = courseCell.textContent;
                const deliveryDateCell = row.querySelector("td:nth-child(9)");
                const deliveryDate = deliveryDateCell.textContent;
                const statusCell = row.querySelector("td:nth-child(10)");
                const statusValue = statusCell.textContent;
                
                const statCell = row.querySelector("td:nth-child(8)");
                const statValue = statCell.textContent;
                
                
                const costCell = row.querySelector("td:nth-child(7)");
                const costValue = parseFloat(costCell.textContent);

                const dateMatch = (filterOption === "all" || filterOption === "course" || filterOption === "delivery_date" || filterOption === "status" || filterOption === "cost") || filterOption === "stat"
                    || (new Date(date) >= new Date(fromDate) && new Date(date) <= new Date(toDate));
                const courseMatch = (filterOption === "all" || filterOption === "date" || filterOption === "delivery_date" || filterOption === "status" || filterOption === "cost")  || filterOption === "stat"
                    || (courseFilter === '' || courseValue === courseFilter);
                const deliveryDateMatch = (filterOption === "all" || filterOption === "date" || filterOption === "course" || filterOption === "status" || filterOption === "cost")   || filterOption === "stat"
                    || (new Date(deliveryDate) >= new Date(fromDeliveryDate) && new Date(deliveryDate) <= new Date(toDeliveryDate));
                const statusMatch = (filterOption === "all" || filterOption === "date" || filterOption === "course" || filterOption === "delivery_date" || filterOption === "cost")   || filterOption === "stat"
                    || (statusFilter === '' || statusValue === statusFilter);
                
                const statMatch = (filterOption === "all" || filterOption === "date" || filterOption === "course" || filterOption === "delivery_date" || filterOption === "cost")    || filterOption === "status"
                || (statFilter === '' || statValue === statFilter);
                
                const costMatch = (filterOption === "all" || filterOption === "date" || filterOption === "course" || filterOption === "delivery_date" || filterOption === "status")   || filterOption === "stat"
                    || (isNaN(minCost) || isNaN(maxCost) || (costValue >= parseFloat(minCost) && costValue <= parseFloat(maxCost)));

                row.style.display = (dateMatch && courseMatch && deliveryDateMatch && statusMatch && costMatch && statMatch) ? "table-row" : "none";
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
            document.getElementById("from_delivery_date").value = '';
            document.getElementById("to_delivery_date").value = '';
            document.getElementById("status").value = '';
            document.getElementById("stat").value = '';
            document.getElementById("min_cost").value = '';
            document.getElementById("max_cost").value = '';

            showFilterOptions(); // Hide all filter options divs again
        }
    </script>
		

    
</body>
</html>