<%@page import="java.util.UUID"%>
<%@page import="sample.application.Token"%>
<%@page import="sample.application.Store"%>
<%@page import="sample.application.QrImage"%>
<%@page import="sample.application.LidoUtil"%>
<%

String cpath = this.getServletContext().getContextPath();

String tid = request.getParameter("tid");
String url = request.getRequestURL().toString();

url = LidoUtil.makeLink(url, cpath, "/lido/checkLidoKeyid.jsp?tid=" + tid);

System.out.println( "\n" );
System.out.println( "==qr==" );
System.out.println( "tid=" + tid );
System.out.println( "url=" + url );

byte[] img = QrImage.getQRCodeImage( url, 150, 150, "PNG" );

out.clear();

response.setContentType( "image/png" );

response.getOutputStream().write( img );
response.getOutputStream().flush();
%>