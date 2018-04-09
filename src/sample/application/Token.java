package sample.application;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Header;
import io.jsonwebtoken.Jwt;

public class Token {

	private String tid = null;
	private long expireAt  = 0;
	private String data = null;
	private Jwt<Header<?>,Claims> jwt = null;
	
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public long getExpireAt() {
		return expireAt;
	}
	public void setExpireAt(long expireAt) {
		this.expireAt = expireAt;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}
	public Jwt<Header<?>, Claims> getJwt() {
		return jwt;
	}
	public void setJwt(Jwt<Header<?>, Claims> jwt) {
		this.jwt = jwt;
	}
	@Override
	public String toString() {
		return "Token [tid=" + tid + ", expireAt=" + expireAt + ", data=" + data + ", jwt=" + jwt + "]";
	}
	
}
