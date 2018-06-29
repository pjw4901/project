/**
 * 
 */
package com.javateam.springBoard.vo;

import javax.validation.constraints.Size;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author ss
 *
 */

@Data
public class BoardDTO {
	
	private int boardNum; //글 번호
	
	@Size(min=1, max=30, message="작성자를 입력하십시오")
	private String boardName;
	
	@Size(min=8, max=15, message="비밀번호 8~15자로 입력하세요")
	private String boardPass;
	
	@Size(min=1, max=50, message="글제목을 입력하십시오")
	private String boardSubject;
	
	@Size(min=1, max=2000, message="글내용을 입력하십시오")
	private String boardContent;
	
	private MultipartFile boardFile; //첨부파일
	private int boardReRef; // 관련글 번호
	private int boardReLev; // 답글 레벨
	private int boardReSeq; // 관련글 중 출력 순서
	private int boardReadCount = 0; // 조회수
	private String boardDate; // 작성일
	

}
