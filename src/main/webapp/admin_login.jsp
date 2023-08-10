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
		<section>
			<div>		
			<!-- 	<a href="registration.jsp" class="signup-image-link">Create an  account</a>   -->
					</div>

					<div>	
						<h2>Sign In</h2>
						
						<form method="post" action="AdminLogin">
							<div>
								<input
									type="text" name="username" id="username"
									placeholder="Enter Admin login Id" />
							</div>
							<br>
							
						<!-- 	<div>
								<input
									type="text" name="type_id" id="type_id"
									placeholder="Enter login Type Id" />
							</div>
						 -->	
							<div>
								 <input
									type="password" name="password" id="password"
									placeholder="Password" />
							</div>
							<div>
								<input type="checkbox" name="remember-me"/>
								 <span> Remember Me </span>
							</div>
							<div>
								<input type="submit" name="signin" value="Sign In" />
							</div>
						</form>
						
					</div>
			
		</section>

	</div>
	<!-- JS -->

	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type = "text/javascript">

var status = document.getElementById("status").value;
if(status=="failed"){
	swal("Sorry","Wrong Username or Password","error");
}

</script>
  
</body>

</html>