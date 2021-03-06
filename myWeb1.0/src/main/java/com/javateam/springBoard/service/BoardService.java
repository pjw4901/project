/**
 * 
 */
package com.javateam.springBoard.service;

import java.util.List;

import com.javateam.springBoard.vo.BoardVO;
import com.javateam.vo.CommUserVO;

/**
 * @author ss
 *
 */
public interface BoardService {
	
	void insertBoard(BoardVO boardVO);
	int getListCount();
	List<BoardVO> getArticleList(int page, int limit);
	BoardVO getArticle(int boardNum);
	void updateReadCount(int boardNum);
	void updateBoard(BoardVO boardVO);
	void deleteBoard(int boardNum);
	CommUserVO getUser(String userid);
	void updateUser(String userid, String content);

}
