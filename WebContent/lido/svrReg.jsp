<%@page import="sample.application.User"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@page import="java.util.UUID"%>
<%@page import="io.jsonwebtoken.Jwts"%>
<%@page import="io.jsonwebtoken.Jwt"%>
<%@page import="io.jsonwebtoken.Header"%>
<%@page import="io.jsonwebtoken.Claims"%>
<%@page import="io.jsonwebtoken.impl.TextCodec"%>
<%@page import="java.security.PublicKey"%>
<%@page import="java.security.KeyFactory"%>
<%@page import="java.security.spec.X509EncodedKeySpec"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%

String cpath = this.getServletContext().getContextPath();

String userId = (String)session.getAttribute( "userId" );
String tid = (String)session.getAttribute( "tid" );
String jwtString = request.getParameter( "jwt" );

System.out.println( "\n" );
System.out.println( "==svrReg==" );
System.out.println( "tid=" + tid );
System.out.println( "userId=" + userId );
System.out.println( "jwtString=" + jwtString );

int lastpos = jwtString.lastIndexOf( "." );

Jwt<Header<?>,Claims> jwt = Jwts.parser().parse( jwtString.substring(0,lastpos+1) );

String keyid = jwt.getBody().get("keyid", String.class);
String data = jwt.getBody().get("data", String.class);
String b64Pubkey = jwt.getBody().get("key", String.class);

System.out.println( "pubKey=" + b64Pubkey );

byte[] bytesPubkey = TextCodec.BASE64.decode( b64Pubkey );
PublicKey pubkey = KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(bytesPubkey));

boolean verified = false;

try{

	jwt = Jwts.parser().setSigningKey( pubkey).parse( jwtString );

	System.out.println( "jwt=" + jwt );

	Store store = Store.getInstance();
	
	store.regLido( userId, keyid, b64Pubkey );
	
	Token token = store.getToken(tid);
	token.setJwt( jwt );
	
	verified = true;
	
}catch(Exception e){
	
	e.printStackTrace();
}

System.out.println( "verified=" + verified );


String pgTitle = "5. New LIDO key created";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
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
<script>

</script>
<body>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title"><%=pgTitle %></h5>
					<p>
					<%if( verified ){ %>
					The key is registered to <b><%=userId %></b>
					<%} else{ %>
					LIDO key verification error.
					<%} %>
					</p>
					<%if( verified ){ %>
					Close LIDO client <br>Goto the service login page
					<%} %>	
				</div>
			</div>
		</div>
		<div class="w-100"></div>
		<div class="col">
			<ul class="list-group">
				<li class="list-group-item list-group-item-secondary">{ tid + userId + keyid }</li>
	  			<li class="list-group-item">tid=<%=tid %></li>
	  			<li class="list-group-item">userId=<%=userId %></li>
	  			<li class="list-group-item">keyid=<br><%=keyid %></li>
			</ul>
		</div>		
	</div>
</div>
</body>
</html>