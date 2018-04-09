package sample.application;

public class Utils {

	public static String base64Encode(byte[] input) {
		
		return java.util.Base64.getEncoder().encodeToString( input );
	}
	
	public static byte[] base64Decode(String input) {
		
		return java.util.Base64.getDecoder().decode( input );
	}
}
