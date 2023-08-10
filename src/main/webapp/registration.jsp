<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form</title>
<link rel="stylesheet" href="style2.css">
</head>
<body>

<input type = "hidden" id= "status" value="<%= request.getAttribute("status")%>">
	
	 <div align = "center">
		<!-- Sign up form -->
		<section>
					<div>
						<h2>Sign up</h2>
					<br>
						<form method="post" action="register">
							<div>
							<input type="text" name="fname" id="name" placeholder="First Name" />									
							</div>
							<br>
							<div>
							<input type="text" name="lname" id="name" placeholder="Last Name" />									
							</div>
							<br>
							<div>
								<input type="email" name="email" id="email" placeholder="Enter Email" />
							</div>
							<br>
						 	 	<div>
								<input type="password" name="pass" id="pass" placeholder="Password" />
							</div>
							<br>
							<div>
								<input type="password" name="con_pass" id="re_pass" placeholder="Confirm Password" />
							</div>
						 
						 <br>
							<div>
								<input type="text" name="contact" id="contact" placeholder="Mobile no." />
							</div>
					
							<br>
						
							<div>
								<input type="submit" name="signup" value="Register" />
							</div>
						</form>
				
					
       
						<br>
						
					</div>
					<div>
						<a href="login.jsp" >I am already member</a>
					</div>		
		</section>
	</div>
	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type = "text/javascript">

var status = document.getElementById("status").value;
if(status=="success"){
	swal("Congrats","Account Created Successful","success");
}

else if(status=="Password Not Matched"){
	swal("Sorry","Password Not Matched","error");
}

</script>
  
</body>

</html>