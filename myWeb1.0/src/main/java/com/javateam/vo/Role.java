/**
 * 
 */
package com.javateam.vo;

import org.springframework.security.core.GrantedAuthority;

/**
 * @author ss
 *
 */
public class Role implements GrantedAuthority {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6580332523366316329L;
	
	private String userid;
	private String role;
	
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String getAuthority() {
		return this.role;
	}
	

}
