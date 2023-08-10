<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="propoStyle.css">

<body>

<ul class="menu">
	
	<li><a href="index.jsp">Home</a></li>
	 <li > <a href="#"> Proposal Management </a>
        
        <ul class = "dropdown">

        <li><a href = "proposal_sum.jsp">Proposal Summary</a></li>
        <li><a href = "view.jsp">View Records</a></li>
       <li><a href = "WorkOrder.jsp">Upload Work Order</a></li>
        <li><a href = "scheduling.jsp">Scheduling</a></li>
        
        </ul></li>
         
                    <li ><a href="#about">About</a></li>
					<li ><a	href="#contact">Contact</a></li>
					<li ><a href="logout">Logout</a></li>
					
    </ul>
    
    
    <h1>Select View Record:</h1>

  <!-- Dropdown menu -->
  <select id="optionSelect">
    <option value="" selected disabled>Select</option>
    <option value="proposal_view.jsp">Proposal</option>
    <option value="orders_view.jsp">Work Order</option>
    <option value="schedule_view.jsp">Scheduling</option>
  </select>

  <!-- "View Records" button -->
  <button onclick="redirectToSelectedOption()">View Records</button>

  <script>
    function redirectToSelectedOption() {
      // Get the selected option value from the dropdown
      var selectedOption = document.getElementById("optionSelect").value;

      // Redirect to the selected option's link page
      if (selectedOption) {
        window.location.href = selectedOption;
      }
    }
  </script>
	
	
	<!-- 
	
<br><br>
   <div  >  <a href = "proposal_view.jsp"  style="font-size:40px;color:#964B00;">View Proposal Summary Records</a> </div>
	    	
<br><br>

<div >  <a href = "order_view.jsp"  style="font-size:40px;color:#964B00;">View Work Order Records</a> </div>
   
   <br><br>

<div >  <a href = "schedule_view.jsp"  style="font-size:40px;color:#964B00;">View Scheduled Records</a> </div>
    
    -->

</body>
</html>