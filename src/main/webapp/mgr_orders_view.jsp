<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>


<!DOCTYPE html>

<html>
<head>
    <title>Display Data</title>
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
	
	<li><a href="">Home</a></li>
	 <li > <a href="#"> Proposal Management </a>
        
        <ul class = "dropdown">

        <li><a href = "mgr_proposal.jsp">Upload Proposals </a></li>
        <li><a href = "mgr_proposal_view.jsp">View Proposal</a></li>
       <li><a href = "mgr_order.jsp">Upload Work Order</a></li>
        <li><a href = "mgr_orders_view.jsp">View Work Order</a></li>
        
        </ul></li>
         
                <!--     <li ><a href="#about">About</a></li> -->
				<!-- 	<li ><a	href="#contact">Contact</a></li>   -->
				
				 <li ><a href="logout">Logout</a></li>  
					
    </ul>
	
<br>
   
<h3>Work Order Summary</h3>

<br>

    <form id="filterForm">
        <label for="filter">View By:</label>
        <select id="filter" name="filter" onchange="showFilterOptions()">
            <option value="all" selected disabled>All Data</option>
            <option value="date">Date</option>
            <option value="course">Proposal Name</option>
        </select>

        <div id="dateFilter" style="display: none;">
            <label for="from_date">From Date:</label>
            <input type="date" id="from_date" name="from_date">
            <label for="to_date">To Date:</label>
            <input type="date" id="to_date" name="to_date">
        </div>
        
        <div id="courseFilter" style="display: none;">
        <label for="course">Select Proposal Name</label>
         <select  id="course" name="course">
				 <option value="" selected disabled> Select </option>
				 <%
				 
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false","root","mysql");
					Statement st = con.createStatement();
					String query = "SELECT * from ctp_proposals";
					//getting table data 
					ResultSet rs = st.executeQuery(query);
					
					//to get P_name(proposal name) one by one 
					
					while(rs.next()){
						%>
						<option><%=rs.getString("proposal_name") %></option>
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
			
       

    <table id="dataTable">
        <thead>
				<tr><th scope="col">WO Id</th>
					<th scope="col">Proposal Type</th>
					<th scope="col">WO Submit Date</th>
					<th scope="col">WO payment Status</th>
					<th scope="col">Work Order Files</th>
					
					<th scope="col">Uploaded Files</th>
					

				</tr>
			</thead>
			<tbody>
				<%
				Class.forName("com.mysql.cj.jdbc.Driver");
				 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/corporate_training_mgmt_db?useSSL=false",
						"root", "mysql");
				PreparedStatement ps = conn.prepareStatement("select ctp_work_order.*, ctp_proposals.proposal_name FROM ctp_work_order INNER JOIN ctp_proposals ON ctp_work_order.proposal_id = ctp_proposals.proposal_id");
				
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("WO_id") %></td>
					<td><%=rs.getString("proposal_name") %></td>
					<td><%=rs.getString("WO_Submit_date") %></td>
					<td><%=rs.getString("WO_payment_status") %></td>
					<td><%=rs.getString("WO_file") %></td>
					
					<td>
                    <a href= "<%= rs.getString("WO_file_location") %>" target="_blank">View File</a>
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

            if (filterOption === "date") {
                dateFilterDiv.style.display = "block";
                courseFilterDiv.style.display = "none";
            } else if (filterOption === "course") {
                dateFilterDiv.style.display = "none";
                courseFilterDiv.style.display = "block";
            } else {
                dateFilterDiv.style.display = "none";
                courseFilterDiv.style.display = "none";
            }
        }

        function applyFilter() {
            const filterOption = document.getElementById("filter").value;
            const fromDate = document.getElementById("from_date").value;
            const toDate = document.getElementById("to_date").value;
            const courseFilter = document.getElementById("course").value;

            const rows = document.querySelectorAll("#dataTable tbody tr");
            rows.forEach(row => {
                const dateCell = row.querySelector("td:nth-child(3)"); 
                const date = dateCell.textContent;
                const courseCell = row.querySelector("td:nth-child(2)"); 
                const courseValue = courseCell.textContent;

                const dateMatch = (filterOption === "all" || filterOption === "course") || (new Date(date) >= new Date(fromDate) && new Date(date) <= new Date(toDate));
                const courseMatch = (filterOption === "all" || filterOption === "date") || (courseFilter === '' || courseValue === courseFilter);

                row.style.display = (dateMatch && courseMatch) ? "table-row" : "none";
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
            document.getElementById("dateFilter").style.display = "none";
            document.getElementById("courseFilter").style.display = "none";
        }
    </script>
    
    <!--  
        
      <br><br>
		<br>
     
     <div  >  <a href = "proposal_view.jsp"  style="font-size:35px;color:#964B00;">View Proposal Summary Records</a> </div>
   
   <br><br>

<div>  <a href = "schedule_view.jsp"  style="font-size:35px;color:#964B00;">View Scheduled Records</a> </div>
   
     -->
    
      
</body>
</html>
