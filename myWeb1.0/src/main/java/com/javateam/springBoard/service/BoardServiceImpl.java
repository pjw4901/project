/**
 * 
 */
package com.javateam.springBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javateam.springBoard.repository.MybatisDAO;
import com.javateam.springBoard.vo.BoardVO;

import lombok.extern.java.Log;

/**
 * @author ss
 *
 */
@Service
@Log
public class BoardServiceImpl implements BoardService {

	@Autowired
	private MybatisDAO dao;
	/**
	 * @see com.javateam.springBoard.service.BoardService#insertBoard(com.javateam.springBoard.vo.BoardVO)
	 */
	@Override
	public void insertBoard(BoardVO board) {

		log.info("게시물 저장 (serviceimpl)");
		dao.insert(board);

	}
	
	/**
	 * @see com.javateam.springBoard.service.BoardService#getArticleList(int,int)
	 */
	@Override
	public List<BoardVO> getArticleList(int page, int limit) {
		log.info("getArticleList servuceimpl");
		return dao.getListByPageAndLimit(page, limit);
	}
	/**
	 * @see com.javateam.springBoard.service.BoardService#getListCount()
	 */
	@Override
	public int getListCount() {
		log.info("getListCount serviceimpl");
				
		return dao.list().size();
	}
	
	/**
	 * @see com.javateam.springBoard.service.BoardService#getArticle(int)
	 */
	@Override
	public BoardVO getArticle(int boardNum) {
		log.info("getArticle serviceimpl");
		return dao.get(boardNum);
	}
	
	/**
	 * @see com.javateam.springBoard.service.BoardService#updateReadCount(int)
	 */
	@Override
	public void updateReadCount(int boardNum) {
		log.info("updateReadCount serviceimpl");
		dao.updateReadCount(boardNum);
		
	}

	@Override
	public void updateBoard(BoardVO board) {
		log.info("updateBoard serviceImpl");
		dao.update(board);
		
	}

	@Override
	public void deleteBoard(int boardNum) {
		log.info("deleteBoard serviceImpl");
		dao.delete(boardNum);
		
	}

}
