/**
 * 
 */
package com.javateam.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

/**
 * @author ss
 *
 */

@Entity
@Table(name="comm_users")
@Data
public class CommUserVO {
	
	@Id
	@Column(name="user_id")
	private String userid;
	
	@Column(name="summoner_id", nullable=false, length=50)
	private String summonerid;
	
	@Column(name="comm_lv", nullable=false, length=10)
	private int commlv;
	
	@Column(name="comm_wins", length=10)
	private int commwins;
	
	@Column(name="comm_losses", length=10)
	private int commlosses;
	
	@Column(name="comm_content", length=1000)
	private String commcontent;
	
}
