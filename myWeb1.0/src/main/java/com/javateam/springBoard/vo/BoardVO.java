package com.javateam.springBoard.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.javateam.springBoard.vo.BoardDTO;

import lombok.Data;

@Entity
@Table(name="board_tbl")
@Data
public class BoardVO {
	
	@Id
	@Column(name="board_num")
	@GeneratedValue(strategy = GenerationType.AUTO) //hibernate 자동 시퀀스
	private int boardNum; //글 번호
	
	@Column(name="board_name", nullable=false, length=30)
	private String boardName;//글 작성자
	
	@Column(name="board_pass", nullable=false, length=15)
	private String boardPass;//글 비밀번호
	
	@Column(name="board_subject", nullable=false, length=50)
	private String boardSubject;//글 제목
	
	@Column(name="board_content", nullable=false, length=2000)
	private String boardContent; //글 내용
	
	@Column(name="board_file", length=2000)
	private String boardFile; //첨부 파일
	
	@Column(name="board_re_ref")
	private int boardReRef; //관련글 번호
	
	@Column(name="board_re_lev")
	private int boardReLev; //답글 레벨
	
	@Column(name="board_re_seq")
	private int boardReSeq; //관련글 줄 출력 순서
	
	@Column(name="board_read_count")
	private int boardReadCount = 0; //조회수
	
	@Column(name="board_date", nullable=false, length=21)
	private String boardDate; //작성일
	
	public BoardVO() {}
	
	// BoardDTO -> BoardVO
	public BoardVO(BoardDTO board) {
		
		this.boardNum = board.getBoardNum();
		this.boardName = board.getBoardName();
		this.boardPass = board.getBoardPass();
		this.boardSubject = board.getBoardSubject();
		this.boardContent = board.getBoardContent();
		this.boardFile = board.getBoardFile().getOriginalFilename(); // 파일명 저장
		this.boardReRef = board.getBoardReRef();
		this.boardReLev = board.getBoardReLev();
		this.boardReSeq = board.getBoardReSeq();
		this.boardReadCount = board.getBoardReadCount();
		this.boardDate = board.getBoardDate();
	}
	

}
