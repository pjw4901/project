/**
 * 
 */
package com.javateam.springBoard.repository;

import java.util.List;

import com.javateam.springBoard.vo.BoardVO;

/**
 * @author ss
 *
 */
public interface MybatisDAO {
	
	void insert(BoardVO board);
	List<BoardVO> list();
	void update(BoardVO board);
	boolean delete(int boardNum);
	BoardVO get(int boardNum);
	List<BoardVO> getListByPageAndLimit(int page, int limit);
	void updateReadCount(int boardNum);

}
