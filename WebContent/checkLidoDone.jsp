<%@page import="java.util.Random"%>
<%@page import="sample.application.User"%>
<%@page import="java.util.List"%>
<%@page import="java.util.UUID"%>
<%@page import="io.jsonwebtoken.Jwts"%>
<%@page import="io.jsonwebtoken.Jwt"%>
<%@page import="io.jsonwebtoken.Header"%>
<%@page import="io.jsonwebtoken.Claims"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@page import="sample.application.LidoUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

String cpath = this.getServletContext().getContextPath();
String tid = request.getParameter( "tid" );

System.out.println( "\n" );
System.out.println( "==checkLidoDone==" );
System.out.println( "tid=" + tid );

Store store = Store.getInstance();
Token token = store.getToken( tid );

Jwt<Header<?>,Claims> jwt = token.getJwt();

System.out.println( "jwt=" + jwt );

String userid = null;
String keyid = null;

if( jwt!=null ){
	
	keyid = jwt.getBody().get("keyid", String.class);
	
	User user = store.selectUserByLido( keyid );
	userid = user.getId();
	
} 

System.out.println( "userid=" + userid );
System.out.println( "keyid=" + keyid );

String message = "";

if( userid==null || keyid==null ){
	message = "LIDO Login failed";
} else {
	message = "User ID : " + userid + "<br>keyid : " + keyid + "<br>" + new java.util.Date();
}


String pgTitle = "LIDO login";
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
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title"><%=pgTitle %></h5>
					<p>
					<%=message %>
					</p>
					<a href="<%=cpath%>/index.jsp" class="btn btn-primary">goto Login</a>

				</div>
			</div>
		</div>
	</div>
</body>
</html>