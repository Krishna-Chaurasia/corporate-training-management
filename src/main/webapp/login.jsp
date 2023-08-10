<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.*" import="javax.sql.*"%>

<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign in Form</title>
<link rel="stylesheet" href="style2.css">


</head>
<body >
<input type = "hidden" id= "status" value="<%= request.getAttribute("status")%>">

  <div align = "center">
		
			<div>		
				<a href="registration.jsp" class="signup-image-link">Create an  account</a>
					</div>

					<div>
						<h2>Sign In</h2>
						
						<form method="post" action="Login">
							<div>
								<input
									type="text" name="username" id="username"
									placeholder="Enter Login_id" />
							</div>
							
						<br>
								<div>
								 <input
									type="password" name="password" id="password"
									placeholder="Password" />
							</div>
							
								<br>
							
							
							<div>
								<input type="submit" name="signin" value="Sign In" />
							</div>
							
							</form>
							
					</div>
						
			
		


	
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	
<script type = "text/javascript">

var status = document.getElementById("status").value;
if(status=="failed"){
	swal("Sorry","Wrong Login id or Password","error");
}

else if(status=="match"){
	swal("Sorry","Not Assigned Role","error");
}
</script>


  
</body>

</html>

