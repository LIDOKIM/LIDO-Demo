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

String tid = request.getParameter( "tid" );
String jwtString = request.getParameter( "jwt" );


System.out.println( "\n" );
System.out.println( "==doUpdateToken==" );
System.out.println( "tid=" + tid );
System.out.println( "jwtString=" + jwtString );


int lastpos = jwtString.lastIndexOf( "." );
Jwt<Header<?>,Claims> jwt = Jwts.parser().parse( jwtString.substring(0,lastpos+1) );

//find public keu
String keyid = jwt.getBody().get("keyid", String.class);

System.out.println( "keyid=" + keyid );

Store store = Store.getInstance();
User user = store.selectUserByLido(keyid);

System.out.println( "userId=" + user.getId() );
System.out.println( "pubKey=" + user.getKey() );

byte[] bytesPubkey = TextCodec.BASE64.decode( user.getKey() );
PublicKey pubkey = KeyFactory.getInstance("RSA").generatePublic(new X509EncodedKeySpec(bytesPubkey));

boolean verified = false;

try{

	jwt = Jwts.parser().setSigningKey( pubkey).parse( jwtString );

	Token token = store.getToken(tid);
	token.setJwt( jwt );
	
	verified = true;
	
}catch(Exception e){
	
	e.printStackTrace();
}

System.out.println( "verified=" + verified );


String pgTitle = "3. Token Update";
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
					found a user - <b><%=user.getId() %></b> by keyid
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
	  			<li class="list-group-item">userId=<%=user.getId() %></li>
	  			<li class="list-group-item">keyid=<br><%=keyid %></li>
			</ul>
		</div>		
	</div>
</div>
</body>
</html>