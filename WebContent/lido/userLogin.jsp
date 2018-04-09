<%@page import="java.util.Random"%>
<%@page import="sample.application.User"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@page import="sample.application.LidoUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String cpath = getServletContext().getContextPath();
	String tid = request.getParameter( "tid" );
	
	String pgTitle = "2. Password authentication";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title><%=pgTitle%></title>
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
<link rel="stylesheet" type="text/css"	href="<%=cpath%>/css/bootstrap.css">
<body>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title"><%=pgTitle%></h5>
					<form id="fmLogin" action="doPwdLogin.jsp?tid=<%=tid %>" method="POST">
						<div class="input-group mb-3">
							<input type="text" name="id" class="form-control"
								value="test"
								placeholder="User ID" aria-label="User ID">
						</div>
						<div class="input-group mb-3">
							<input type="password" name="pwd" class="form-control"
								value="test"
								placeholder="Password" aria-label="Password">
						</div>
					</form>
					<a href="javascript: document.forms['fmLogin'].submit();"	class="btn btn-primary">Login</a>
				</div>
			</div>
		</div>
		<div class="w-100"></div>
		<div class="col">
			<ul class="list-group">
				<li class="list-group-item list-group-item-secondary">{ tid + userId }</li>
	  			<li class="list-group-item">tid=<%=tid %></li>
	  			<li class="list-group-item">userId=?</li>
			</ul>
		</div>	
	</div>
</div>
</body>
</html>
