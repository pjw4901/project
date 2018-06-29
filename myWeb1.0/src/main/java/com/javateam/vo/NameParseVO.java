/**
 * 
 */
package com.javateam.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

/**
 * @author ss
 *
 */
@Data
public class NameParseVO {
	
	
	private long id;
	private long accountId;
	private String name;
	private int profileIconId;
	private long revisionDate;
	private long summonerLevel;

	
}
