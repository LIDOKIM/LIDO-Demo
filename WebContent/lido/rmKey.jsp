<%@page import="sample.application.User"%>
<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%

String cpath = this.getServletContext().getContextPath();

String tid = request.getParameter( "tid" );
String keyid = request.getParameter( "keyid" );

String pgTitle = "99. Remove LIDO Key";
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
			
			var frm = document.getElementById("frm");
			frm.action = "checkLidoKeyid.jsp?tid=<%=tid%>";
			frm.submit();

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
		
		var reqJsonStr = '{ "command" : "rmKey" }';
		
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
</form>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title"><%=pgTitle %></h5>
					<p>Not found keyid, remove LIDO Key. and than register again.</p>
					<a href="javascript:lidoGetKeyid();" class="btn btn-primary">rmKey()</a>
				</div>
			</div>
		</div>
		<div class="w-100"></div>
		<div class="col">
			<ul class="list-group">
				<li class="list-group-item list-group-item-secondary">{ tid + keyid }</li>
	  			<li class="list-group-item">tid=<%=tid %></li>
	  			<li class="list-group-item">keyid=<%=keyid %></li>
			</ul>
		</div>		
	</div>
</div>
</body>
</html>