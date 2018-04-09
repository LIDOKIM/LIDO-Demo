package sample.application;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Store {

	private static Logger logger = LoggerFactory.getLogger(Store.class);

	private Map<String,User> users = new HashMap<>();
	private Map<String,String> link = new java.util.LinkedHashMap<>();

	private Map<String,Token> tokens = new HashMap<>(); // token expire is not implemented at this sample
	
	private static class SingletonHelper {
		private static final Store INSTANCE = new Store();
	}

	public static Store getInstance() {
		return SingletonHelper.INSTANCE;
	}
	
	private Store(){

		User tuser = new User();
		tuser.setId( "test" );
		tuser.setPwd( "test" );
		
		users.put( tuser.getId(), tuser );
		
		logger.debug("store init");
	}

	public void insertUser(User user) {

		users.put( user.getId(), user );
		
	}
	
	public User selectUser(String id) {
		
		return users.get( id );
	}

	
	public User selectUserByLido(String keyid) {
		
		String id = link.get( keyid );
		
		if( id!=null ) return users.get( id );
		
		return null;
	}

	
	public User regLido(String id, String keyid, String key) {

		User user = users.get( id );
		
		if( user==null ) return null;
		
		user.setKeyid(keyid);
		user.setKey(key);
		
		link.put( keyid, id );
		
		return user;
	}

	public List<User> userList(){
		
		List<User> list = new ArrayList<>(users.values());
		
		return list;
	}


	public void saveToken(Token token) {
		tokens.put( token.getTid(), token );
	}
	
	public Token getToken(String tid) {
		return tokens.get( tid );
	}
}
