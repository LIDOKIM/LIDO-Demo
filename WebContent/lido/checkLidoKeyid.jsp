<%@page import="sample.application.User"%>
<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%

String cpath = this.getServletContext().getContextPath();

String tid = request.getParameter( "tid" );

System.out.println( "\n" );
System.out.println( "==checkLidoKeyid==" );
System.out.println( "tid=" + tid );

String pgTitle = "1. Registration check";
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
			
			if( json.keyid == "" ){

				if( confirm( "Not found keyid. You need lido registration first." ) ){

					var frm = document.getElementById("frm");
					
					frm.action = "userLogin.jsp";
					frm.submit();
				}

			} else {
		
				if( confirm( "This lido client is already registered.\nDo you login with lido?" ) ){
	
					document.getElementById("keyid").value = json.keyid; 
					
					var frm = document.getElementById("frm");
					
					frm.action = "sign.jsp";
					frm.submit();
					
				}
			}

		} else {
	
			alert( "lido error[" + json.returnCode + "] - " + json.error );
		}
		
	}
	catch(err) {
		
	    alert( "lidoResponse.err:" +  err.message );
	}
}

function lidoGetKeyid(){
	
	try{
		
		var reqJsonStr = '{ "command" : "getKeyid" }';
		
		lido.request( reqJsonStr  );
		
	}
	catch(err) {
		
	    alert( "lidoGet.err:" +  err.message );
	}	
}

</script>
<body>
<form id="frm" method="POST">
<input type="hidden" name="tid" value="<%=tid %>"/>
<input type="hidden" name="keyid" id="keyid"/>
</form>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title"><%=pgTitle %></h5>
					<p>if not found keyid, not registered, you need lido registration</p>
					<a href="javascript:lidoGetKeyid();" class="btn btn-primary">getKeyid()</a>
				</div>
			</div>
		</div>
		<div class="w-100"></div>
		<div class="col">
			<ul class="list-group">
				<li class="list-group-item list-group-item-secondary">{ tid }</li>
	  			<li class="list-group-item">tid=<%=tid %></li>
			</ul>
		</div>		
	</div>
</div>
</body>
</html>