package sample.application;

public class User {

	private String id = null; //original user id
	private String pwd = null; //original user pwd
	
	private String keyid = null;  //keyid
	private String Key = null; //key
	
	public User() {
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getKeyid() {
		return keyid;
	}

	public void setKeyid(String keyid) {
		this.keyid = keyid;
	}

	public String getKey() {
		return Key;
	}

	public void setKey(String key) {
		Key = key;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", pwd=" + pwd + ", keyid=" + keyid + ", Key=" + Key + "]";
	}

}
