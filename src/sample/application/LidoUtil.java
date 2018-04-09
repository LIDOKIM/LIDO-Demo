package sample.application;

import java.net.MalformedURLException;
import java.net.URL;

public class LidoUtil {
	
	public static String makeLink( String httpUrl, String cpath, String path ) throws MalformedURLException {
		
		URL url = new URL( httpUrl );
		
		StringBuilder sb = new StringBuilder();
		
		if( "http".equals( url.getProtocol() ) ) sb.append( "lido://" );
		if( "https".equals( url.getProtocol() ) ) sb.append( "lidos://" );
		
		sb.append( url.getHost() );

		if( url.getPort()==80 || url.getPort()==443 ) {
			//nothing
		} else { 
			sb.append( ":" + url.getPort() );
		}
		
		sb.append( cpath );
		sb.append( path );
		
		return sb.toString();
	}
}
