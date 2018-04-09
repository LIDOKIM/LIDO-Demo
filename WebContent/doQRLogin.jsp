<%@page import="sample.application.User"%>
<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%
	String tid = request.getParameter( "tid" );
	String otp =  request.getParameter( "otp" );
	String vuid =  request.getParameter( "vuid" );

	boolean verified = false;
	
	if( tid==null ) tid = "";
	if( otp==null ) otp = "";
	if( vuid==null ) vuid = "";
	
	if( !"".equals(tid) && !"".equals(otp) && !"".equals(vuid) ){
		
		Store store = Store.getInstance();
		User user = store.selectUserByVuid( vuid );
		Token token = store.selectToken( tid );
		
		if( user!=null && token!=null ){
			
			//verify otp
			if( true ){
				
				token.setVuid( vuid );
				store.updateToken( token );
				
				verified = true;
			}
		}
	} 

	String mobileLoginUrl = "mobileLogin.jsp";
		
	if( verified ) mobileLoginUrl = "okGotoPC.jsp";
	
%><jsp:forward page='<%=mobileLoginUrl%>' />