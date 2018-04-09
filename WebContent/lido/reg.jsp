<%@page import="sample.application.User"%>
<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%

String cpath = this.getServletContext().getContextPath();

String tid = request.getParameter( "tid" );
Token token = Store.getInstance().getToken(tid);
String data = token.getData(); //for login
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>LIDO Get</title>
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

	alert( resJsonStr );
	
	try{
		
		var json = JSON.parse( resJsonStr );
		
		if( json.returnCode == "200" ){
			
			if( json.jwt == "" ){

				alert( "lido error - no jwt" );

			} else {

				document.getElementById("jwt").value = json.jwt;
				
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


function lidoReg(){
	
	try{
		
		var reqJsonStr = '{ "command" : "reg", "tid" : "<%=tid%>", "data" : "<%=token.getData()%>" }';
		
		lido.request( reqJsonStr );
		
	}
	catch(err) {
		
		alert( "lidoReg.err:" +  err.message );
	}	
}

</script>
<form id="frm" method="POST">
<input type="hidden" name="jwt" id="jwt"/>
</form>
<body>
	<div class="container">
		<div>
			<div class="card text-center">
				<div class="card-body">
					<h5 class="card-title">LIDO Registration</h5>
					</p>
					<a href="javascript:lidoReg();" class="btn btn-primary">lido.command.reg</a>

				</div>
			</div>
		</div>
	</div>
</body>
</html>