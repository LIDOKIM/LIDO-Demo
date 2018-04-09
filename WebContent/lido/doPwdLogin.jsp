<%@page import="sample.application.User"%>
<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%

String cpath = this.getServletContext().getContextPath();


String tid = request.getParameter( "tid" );
String id = request.getParameter( "id" );
String pwd =  request.getParameter( "pwd" );

Store store = Store.getInstance();
User user = store.selectUser( id );

String message = "";
boolean success = true;

if( user==null || !user.getPwd().equals( pwd ) ){
	message = "User ID or Password incorrect";
	success = false;
} else {
	message = "User ID : " + user.getId() + "<br>" + new java.util.Date();
	
	session.setAttribute( "userId", id );
	session.setAttribute( "tid", tid );
}

String pgTitle = "3. User approval";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title><%=pgTitle %></title>
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
<body>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title"><%=pgTitle %></h5>
					<p>
					<%=message %>
					</p>
					<% if( success ) { %>
					<a href="genLidoKey.jsp"	class="btn btn-primary">goto genKey</a>
					<% } %>
				</div>
			</div>
		</div>
		<div class="w-100"></div>
		<div class="col">
			<ul class="list-group">
				<li class="list-group-item list-group-item-secondary">{ tid + userId }</li>
	  			<li class="list-group-item">tid=<%=tid %></li>
	  			<li class="list-group-item">userId=<%=id%></li>
			</ul>
		</div>	
	</div>
</div>
</body>
</html>