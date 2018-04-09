<%@page import="sample.application.User"%>
<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

String cpath = this.getServletContext().getContextPath();

String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

Store store = Store.getInstance();
User user = store.select( id );

String message = "";

if( user!=null ){
	message = "User exists";
}else{
	
	user = new User();
	user.setId( id );
	user.setPwd( pwd );
	
	store.insertUser( user );
	
	message = "Registered";
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Registration</title>
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
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title">User Registration</h5>
					<p>User ID:&nbsp;<%=user.getId() %>
					<br>
					<%=message %>
					</p>
					<a href="<%=cpath%>/index.jsp" class="btn btn-primary">goto Login</a>

				</div>
			</div>
		</div>
	</div>
</body>
</html>