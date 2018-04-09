<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String cpath = this.getServletContext().getContextPath();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>New User Registration</title>
<style>
html, body {
	height: 100%;
}

.container {
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
</head>
<link rel="stylesheet" type="text/css" href="<%=cpath %>/css/bootstrap.css">
<script>

function addUser(){
	
	var id = document.getElementById("id").value;
	var pwd1 = document.getElementById("pwd1").value;
	var pwd2 = document.getElementById("pwd2").value;

	if( id=="" ){
		alert( "Please input User ID" );
		return;
	}

	if( pwd1=="" ){
		alert( "Please input password" );
		return;
	}

	if( pwd2=="" ){
		alert( "Please input the confirm password" );
		return;
	}

	if( pwd1!=pwd2 ){
		alert( "Password does not match the confirm password" );
		return;
	}
	
	document.forms['frm'].submit();
}

</script>
<body>
	<div class="container">
		<div class="row">
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title">New User Registration</h5>
					<form id="frm" action="doRegister.jsp" method="POST">
						<div class="input-group mb-3">
							<input type="text" id="id" name="id" class="form-control" placeholder="User ID"
								aria-label="User ID">
						</div>
						<div class="input-group mb-3">
							<input type="password" id="pwd1" name="pwd" class="form-control"
								placeholder="Password" aria-label="Password">
						</div>
						<div class="input-group mb-3">
							<input type="password2" id="pwd2" class="form-control"
								placeholder="Confirm Password" aria-label="Confirm Password">
						</div>
					</form>
					<a href="javascript:addUser();" class="btn btn-primary">Register</a>

				</div>
			</div>
		</div>
	</div>
</body>
</html>