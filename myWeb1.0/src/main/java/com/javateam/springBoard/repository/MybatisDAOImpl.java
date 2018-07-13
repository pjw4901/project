/**
 * 
 */
package com.javateam.springBoard.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.transaction.support.TransactionCallback;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import com.javateam.springBoard.vo.BoardMapper;
import com.javateam.springBoard.vo.BoardVO;
import com.javateam.springBoard.vo.PageParamVO;
import com.javateam.vo.CommUserVO;

import lombok.extern.java.Log;

/**
 * @author ss
 *
 */
@Repository
@Log
public class MybatisDAOImpl implements MybatisDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private TransactionTemplate transactionTemplate;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;

	/**
	 * @see com.javateam.springBoard.repository.MybatisDAO#insert(com.javateam.springBoard.vo.BoardVO)
	 */
	@Override
	public void insert(BoardVO board) {
		
		transactionTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				try{
					BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
					boardMapper.insert(board);
				}catch(Exception e){
					log.info("insert(daoimpl) error");
					status.setRollbackOnly(); 
					
				}
				
			}
		});

	}

	/**
	 * @see com.javateam.springBoard.repository.MybatisDAO#list()
	 */
	@Override
	public List<BoardVO> list() {
		List<BoardVO> list = new ArrayList<BoardVO>();
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		
		BoardMapper board = sqlSession.getMapper(BoardMapper.class);
		
		try{
			list = board.list();
			transactionManager.commit(status);
			System.out.println("status flag : " + status.isCompleted());
		}catch(Exception e){
			log.info("list(batisDAOImpl) error"); 
			transactionManager.rollback(status);
			
		}
		
		return list;
	}

	/**
	 * @see com.javateam.springBoard.repository.MybatisDAO#update(com.javateam.springBoard.vo.BoardVO)
	 */
	@Override
	public void update(BoardVO board) {
		transactionTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				try{
					BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
					boardMapper.update(board);
					
					System.out.println("update(DAOImpl) success");
				}catch(Exception e){
					status.setRollbackOnly();
					System.out.println("update(DAOImpl) exception :" + e.getMessage());
					
				}
				
			}
		});

	}

	/**
	 * @see com.javateam.springBoard.repository.MybatisDAO#delete(int)
	 */
	@Override
	public void delete(int boardNum) {
		log.info("deleteBoard DAOImpl");
		transactionTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				try{
					BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
					boardMapper.delete(boardNum);
					
					System.out.println("delete DAOImpl success");
				}catch(Exception e){
					status.setRollbackOnly();
					System.out.println("delete DAOImpl exception : " + e.getMessage());
					
				}
				
			}
		});
		
		
	}

	/**
	 * @see com.javateam.springBoard.repository.MybatisDAO#get(int)
	 */
	@Override
	public BoardVO get(int boardNum) {
		log.info("get(DAOImpl)");
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		
		BoardVO board = new BoardVO();
		
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		
		try{
			board = boardMapper.get(boardNum);
			transactionManager.commit(status);
		}catch(Exception e){
			log.info("get(DAOImpl) error");
			transactionManager.rollback(status);

		}
		
		return board;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<BoardVO> getListByPageAndLimit(int page, int limit) {
		log.info("getListByPageAndLimit");
		
		log.info("page" + page + "  limit" + limit);
		
		List<BoardVO> list = new ArrayList<BoardVO>();
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		
		map.put("page", page);
		map.put("limit", limit);
		
		
/*		PageParamVO pageParamVO = new PageParamVO();
		pageParamVO.setLimit(limit);
		pageParamVO.setPage(page);
		*/
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		
		BoardMapper board = sqlSession.getMapper(BoardMapper.class);
		//list = sqlSession.selectList("com.javateam.springBoard.vo.BoardMapper.getListByPageAndLimit",map);
		
		//list = board.getListByPageAndLimit(pageParamVO);
		try{
			list = board.getListByPageAndLimit(map);
			
			System.out.println("list num 0 : " + list.get(0));
			
			transactionManager.commit(status);
			
		
			System.out.println("getpageandlimit status = " + status.isCompleted());
			log.info("list : " + list);
		}catch(Exception e){
			
			log.info("getListByPageAndLimit error");
			transactionManager.rollback(status);
			
		}
		
		
		return list;
		
		
	}

	/**
	 * @see com.javateam.springBoard.repository.MybatisDAO#updateReadCount(int)
	 */
	@Override
	public void updateReadCount(int boardNum) {
		log.info("updateReadCount(DAOImpl)");
		log.info("boardNum : " + boardNum);
		
		transactionTemplate.execute(new TransactionCallbackWithoutResult() {
			
			@Override
			protected void doInTransactionWithoutResult(TransactionStatus status) {
				try{
					BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
					boardMapper.updateReadCount(boardNum);
					System.out.println("readcount +1 success");
				}catch(Exception e){
					log.info("readcount(DAOImpl) error");
					status.setRollbackOnly();
					
				}
				
			}
		});
		
		
	}

	@Override
	public CommUserVO getUser(String userid) {
		log.info("commUserget(DAOImpl)");
		
		TransactionDefinition def = new DefaultTransactionDefinition();
		TransactionStatus status = transactionManager.getTransaction(def);
		
		CommUserVO commUser = new CommUserVO();
		
		BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
		
		try{
			commUser = boardMapper.getCommUser(userid);
			transactionManager.commit(status);
		}catch(Exception e){
			log.info("get(DAOImpl) error");
			transactionManager.rollback(status);

		}	
		
		return commUser;
	}

}
