<%@page import="java.text.SimpleDateFormat"%>
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
String url = request.getRequestURL().toString();

String agent = request.getHeader("User-Agent");
int browser = 0; // 1: android, 0: others(pc, etc)

if (agent == null) agent = "";
agent = agent.toLowerCase();

if (agent.indexOf("android") >= 0)	browser = 1;

String tid = UUID.randomUUID().toString().replace("-", "");
long expireAt = System.currentTimeMillis() / 1000 + 60 * 3;
long nonce = System.currentTimeMillis();

Token token = new Token();
token.setTid(tid);
token.setExpireAt(expireAt);
token.setData( "" + nonce );

Store store = Store.getInstance();

store.saveToken( token );

List<User> users = store.userList();

String lidoAuthUrl = LidoUtil.makeLink(url, cpath, "/lido/checkLidoKeyid.jsp?tid=" + tid);
String pgTitle = "LIDO Login Sample";

String tt = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" ).format( new java.util.Date() ); 

System.out.println( "\n" );
System.out.println( "==index==" );
System.out.println( "User-Agent=" + agent );
System.out.println( "tid=" + tid );
System.out.println( "data=" + token.getData() );
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
<script>

function lido(){
	
	var mainBtn = document.getElementById("mainBtn");
	var lidoBtn = document.getElementById("lidoBtn");
    
	mainBtn.style.display = 'none';
	lidoBtn.style.display = 'block';
}

</script>
<body>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title"><%=pgTitle%></h5>
					<h6 class="card-title"><%=tt %></h6>
					<form id="fmLogin" action="doPwdLogin.jsp" method="POST">
						<div class="input-group mb-3">
							<input type="text" name="id" class="form-control"
								placeholder="User ID" aria-label="User ID">
						</div>
						<div class="input-group mb-3">
							<input type="password" name="pwd" class="form-control"
								placeholder="Password" aria-label="Password">
						</div>
					</form>
					<div id="mainBtn" >
						<a href="javascript: document.forms['fmLogin'].submit();"
							class="btn btn-primary">Login</a> <a href="newRegister.jsp"
							class="btn btn-primary">New</a>
						<%
							if (browser == 1) {
						%>
						<a href="<%=lidoAuthUrl%>" onclick="javascript: lido();" class="btn btn-primary">LIDO</a>
						<%
							}
						%>
					</div>
					<div id="lidoBtn" style="display: none;">
						<a href="checkLidoDone.jsp?tid=<%=tid %>" class="btn btn-primary">check LIDO Login</a>
					</div>

				</div>
			</div>
		</div>
		<%
			if (browser != 1) {
		%>
		<div class="col">
			<div class="card text-center">

				<div class="card-body">

					<h5 class="card-title">LIDO</h5>
					<img src="QR.jsp?tid=<%=tid%>" width="150px" height="150px">
					<p class="card-text">
						1st. sign with mobile app <br> 2st. click next
					</p>
					<a href="checkLidoDone.jsp?tid=<%=tid %>" class="btn btn-primary">Next</a>
				</div>
			</div>
		</div>
		<%
			}
		%>
		<div class="col">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th scope="col">UserID</th>
						<th scope="col">PWD</th>
						<th scope="col">LIDO</th>
					</tr>
				</thead>
				<tbody>
					<%
						for (int i = 0; i < users.size(); i++) {

							User user = users.get(i);
					%>
					<tr>
						<th scope="row"><%=user.getId()%></th>
						<td><%=user.getPwd()%></td>
						<td>
						<% if( user.getKeyid()!=null ) { %>
						O
						<%} else { %>
						X
						<%} %>
						</td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>
