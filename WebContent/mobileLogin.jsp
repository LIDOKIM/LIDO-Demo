<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Mobile Login</title>
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
<link rel="stylesheet" type="text/css" href="css/bootstrap.css">
<body>
	<div class="container">
		<div>
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title">Mobile ID/Password Login<br>for otp registration</h5>
					<form id="fmLogin" action="doMobileLogin.jsp" method="POST">
						<div class="input-group mb-3">
							<input type="text" name="usrid" class="form-control" placeholder="User ID" aria-label="User ID">
						</div>
						<div class="input-group mb-3">
							<input type="password" name="password" class="form-control" placeholder="Password" aria-label="Password">
						</div>
					</form>
					<a href="javascript: document.forms['fmLogin'].submit();"
						class="btn btn-primary">Login</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>