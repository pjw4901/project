/**
 * 
 */
package com.javateam.springBoard.vo;

import lombok.Data;

/**
 * @author ss
 *
 */

@Data
public class PageInfo {
	
	private int page;		//현재 페이지
	private int maxPage;	//총 페이지
	private int startPage;	//시작페이지
	private int endPage;	//마지막페이지
	private int listCount;	//게시글수

}
