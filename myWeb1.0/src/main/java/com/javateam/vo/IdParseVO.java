/**
 * 
 */
package com.javateam.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author ss
 *
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class IdParseVO {
		
	private String leagueId;
	private String leagueName;
	private String tier;
	private String queueType;
	private String rank;
	private String playerOrTeamId;
	private String playerOrTeamName;
	private int leaguePoints;
	private int wins;
	private int losses;
	private boolean veteran;
	private boolean inactive;
	private boolean freshBlood;
	private boolean hotStreak;
	
}
