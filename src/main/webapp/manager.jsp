
<%
 if(session.getAttribute("name")==null){
	 response.sendRedirect("login.jsp");
	 
 }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>title</title>
<link rel="stylesheet" href="style.css">
<link rel="stylesheet" href="propoStyle.css">

</head>
<body id="page-top">

 <ul class="menu">
   		<li><a href="#">Home</a></li>
        <li > <a href="#"> Proposal Management </a>
        
        <ul class = "dropdown">


        <li><a href = "mgr_proposal.jsp">Upload Proposals</a></li>
        <li><a href = "mgr_proposal_view.jsp">View Proposals</a></li>
      
       <li><a href = "mgr_order.jsp">Upload Work Order</a></li>
       <li><a href = "mgr_orders_view.jsp">view Work Order</a></li>
      
    <!--     <li><a href = "scheduling.jsp">Scheduling</a></li>
         -->
         
        </ul></li>
         
                
					 
					<li ><a href="logout">Logout</a></li> 
					
					
    </ul>
	
  <br>
		<header>
		<div align="center">
			<h1> Welcome Manager </h1>
			
		</div>
	</header>

</body>
</html>
