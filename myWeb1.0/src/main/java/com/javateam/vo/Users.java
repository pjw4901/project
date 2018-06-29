package com.javateam.vo;

public class Users {
	
	private String userid;
	private String username;
	private String userpw;
	private String role;
	private String userjoin;
	private int enabled;
	
	public Users() {}
	
	
	public Users(String userid, String username, String userpw, String role, String userjoin, int enabled) {
		this.userid = userid;
		this.username = username;
		this.userpw = userpw;
		this.role = role;
		this.userjoin = userjoin;
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "Users [userid=" + userid + ", username=" + username + ", userpw=" + userpw + ", role=" + role
				+ ", userjoin=" + userjoin + ", enabled=" + enabled + "]";
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getUserjoin() {
		return userjoin;
	}
	public void setUserjoin(String userjoin) {
		this.userjoin = userjoin;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	
	

}
