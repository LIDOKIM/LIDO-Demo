<%@page import="sample.application.User"%>
<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%

String cpath = this.getServletContext().getContextPath();

String tid = (String)session.getAttribute( "tid" );
String id = (String)session.getAttribute( "id" );

Store store = Store.getInstance();
Token token = store.getToken(tid);

int x = new java.util.Random().nextInt( 100 );

String pgTitle = "4. LIDO key generation";
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

//lido callback function 
function lidoResponse( resJsonStr ){

	try{
		
		var json = JSON.parse( resJsonStr );
		
		if( json.returnCode == "200" ){
			
			if( json.jwt == "" ){

				alert( "Lido key generation error. maybe client bug." );
				return;

			} else {
		
				document.getElementById("jwt").value = json.jwt; //json web token - include RSA public key
				
				var frm = document.getElementById("frm");
				
				frm.action = "svrReg.jsp";
				frm.submit();
			}

		} else {
	
			alert( "lido error[" + json.returnCode + "] - " + json.error );
		}
		
	}
	catch(err) {
		
	    alert( "lidoResponse.err:" +  err.message );
	}
}

function lidoGenKey(){
	
	try{
		
		var reqJsonStr = '{ "command" : "genKey", "title" : "Site<%=x%>", "data" : "<%=token.getData()%>" }';
		
		lido.request( reqJsonStr  );
		
	}
	catch(err) {
		
	    alert( "lidoGenKey.err:" +  err.message );
	}	
}

</script>
<body>
<form id="frm" method="POST">
<input type="hidden" name="jwt" id="jwt">
</form>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title"><%=pgTitle %></h5>
					<p>LIDO client generate a key<br>RSA = { privateKey, publicKey }</p>
					<a href="javascript:lidoGenKey();" class="btn btn-primary">genKey()</a>
				</div>
			</div>
		</div>
		<div class="w-100"></div>
		<div class="col">
			<ul class="list-group">
				<li class="list-group-item list-group-item-secondary">{ tid + userId + keyid }</li>
	  			<li class="list-group-item">tid=<%=tid %></li>
	  			<li class="list-group-item">userId=<%=id %></li>
	  			<li class="list-group-item">keyid=?</li>
			</ul>
		</div>		
	</div>
</div>
</body>
</html>