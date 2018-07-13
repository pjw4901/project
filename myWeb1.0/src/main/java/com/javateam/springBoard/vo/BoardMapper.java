/**
 * 
 */
package com.javateam.springBoard.vo;

import java.util.HashMap;
import java.util.List;

import com.javateam.vo.CommUserVO;

/**
 * @author ss
 *
 */
public interface BoardMapper {
	
	void insert(BoardVO board);
	List<BoardVO> list();
	void update(BoardVO board);
	void delete(int boardNum);
	BoardVO get(int boardNum);
	List<BoardVO> getListByPageAndLimit(HashMap<String, Integer> map);
	//List<BoardVO> getListByPageAndLimit(PageParamVO pageParamVO);
	void updateReadCount(int boardNum);
	CommUserVO getCommUser(String user_id);

}
