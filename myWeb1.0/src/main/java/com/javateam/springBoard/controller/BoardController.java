/**
 * 
 */
package com.javateam.springBoard.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.javateam.springBoard.service.BoardService;
import com.javateam.springBoard.vo.BoardDTO;
import com.javateam.springBoard.vo.BoardVO;
import com.javateam.springBoard.vo.PageInfo;

import lombok.extern.java.Log;

/**
 * 게시판 Controller
 * @author ss
 *
 */
@Controller
//@Slf4j
@Log
@RequestMapping("board")
public class BoardController {
	
	@Autowired
	private FileSystemResource uploadDirResource; //업로드 파일처리
	
	@Autowired
	private BoardService boardSvc;
	
	@RequestMapping("/write.do")
	public String writeBoard(Model model){
		
		System.out.println("/write.do");
		log.info("게시판 글쓰기(/write.do)");
		model.addAttribute("board", new BoardDTO());
		
		return "/board/qna_board_write";
	} // write.do end
	
	
	@RequestMapping("/writeAction.do")
	public String writeAction(@Valid @ModelAttribute("board") BoardDTO boardDTO,
							  BindingResult result,
							  Model model){
		
		log.info("게시판 글쓰기 처리(/writeAction.do)");
		log.info("게시글 == " + boardDTO);
		
		if(result.hasErrors()) { //폼 유효성 점검
			log.info("form invalid");
		
		return "/board/qna_board_write";
		}
		
		MultipartFile file = boardDTO.getBoardFile(); //업로드 파일
		FileOutputStream fos = null;
		BoardVO boardVO = new BoardVO(boardDTO); // DTO -> VO
		
		//업로드 파일처리 부분
		if(!boardDTO.getBoardFile().isEmpty() && file != null) { //파일 유효성 검사
			
			String fileName = file.getOriginalFilename();
			
			//파일 저장소(E:\\lsh\\fileupload)에 저장
			try{
				byte[] bytes = file.getBytes();
				
				File outFileName = new File(uploadDirResource.getPath() + fileName);
				fos = new FileOutputStream(outFileName);
				
				fos.write(bytes);
				
			}catch(IOException e){
				
				log.info("file save error");
				
				e.printStackTrace();
				
			}finally{
				try{
					if(fos != null) fos.close();
				}catch(IOException e){
					log.info("boardcontroller save ioe :");
					e.printStackTrace();
					
				}
				log.info("file upload success!");
				
			} // finally end
			
			
		} //end 파일 처리 if
		
		String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis())).toString();
		
		log.info("등록일 =="+ dateString);
		
		boardVO.setBoardDate(dateString);
		
		log.info("vo에 등록일 =="+ boardVO.getBoardDate());
		
		//게시물 저장
		boardSvc.insertBoard(boardVO);
		
		//결과 메세지 생성
		model.addAttribute("msg", "게시물 저장 성공했습니다.");
		
		
		return "/mainpage"; //메시지 페이지
	}// writeAction.do end
	
	@RequestMapping("/list.do/{page}")
	public String listBoard(@PathVariable("page") int page,
							Model model){
		
		int limit = 10;
		List<BoardVO> articleList;
		
		page = page !=0 ? page : 1;
		
		int listCount = boardSvc.getListCount();
		
		articleList = boardSvc.getArticleList(page, limit);
		
		log.info("articleList" + articleList);
		
		//총 페이지 수.
   		int maxPage=(int)((double)listCount/limit+0.95); //0.95를 더해서 올림 처리.
		// 현재 페이지에 보여줄 시작 페이지 수 (1, 11, 21,...)
   		int startPage = (((int) ((double)page / 10 + 0.9)) - 1) * 10 + 1;
		//현재 페이지에 보여줄 마지막 페이지 수(10, 20, 30, ...)
   	    int endPage = startPage+10-1;
   	    
   	    if(endPage > maxPage) endPage = maxPage;
   	    
   	    PageInfo pageInfo = new PageInfo();
   	    pageInfo.setEndPage(endPage);
   	    pageInfo.setListCount(listCount);
   	    pageInfo.setMaxPage(maxPage);
   	    pageInfo.setPage(page);
   	    pageInfo.setStartPage(startPage);
   	    
   	    model.addAttribute("pageInfo", pageInfo);
   	    model.addAttribute("articleList", articleList);

		return "/board/qna_board_list";
				
	}//list.do end
	
	@RequestMapping("/boardDetail.do/boardNum/{boardNum}/page/{page}")
	public String boardDetail(@PathVariable("boardNum") int boardNum,
							  @PathVariable("page") int page,
							  Model model){
		log.info("boardDetail.do");
		model.addAttribute("nowPage", page);
		model.addAttribute("article", boardSvc.getArticle(boardNum));
		
		//조회수 업데이트
		boardSvc.updateReadCount(boardNum);
		
		
		return "/board/qna_board_view";
	}//일반적인 글보기.
	
	@RequestMapping(value="/boardDetailJSON.do/boardNum/{boardNum}/page/{page}",
					produces="application/json; charset=UTF-8")
	@ResponseBody
	public String boardDetailFeed(@PathVariable("boardNum") int boardNum,
								  @PathVariable("page") int page){
		log.info("boardDetailJSON");
		
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		
		System.out.println("글번호 : " + boardNum);
		
		boardSvc.updateReadCount(boardNum);
		
		BoardVO board = boardSvc.getArticle(boardNum);
		
		log.info("board log info : " + board);
		log.info("조회수 : " + board.getBoardReadCount());
		
		try{
			json = mapper.writeValueAsString(board);
		}catch(JsonProcessingException e){
			log.info("Json1 error ");
			e.printStackTrace();
		}
		
		return json;
	}//boardjson modal end
	
	@RequestMapping(value="/updateBoard.do/{boardNum}",
					produces="text/html; charset=UTF-8")
	@ResponseBody
	public String updateBoard(@PathVariable("boardNum") int boardNum,
							  @RequestParam("update_boardFile_new") MultipartFile file,
							  HttpServletRequest req){
		String msg = "";
		
		log.info("################### updateBoard ######################");
		
		if(req.getParameter("update_boardSubject") == null ||
		   req.getParameter("update_boardSubject").equals(""))
			msg += "글 제목을 입력하세요.\n";
		
		if(req.getParameter("update_boardContent") == null ||
		   req.getParameter("update_boardContent").equals(""))
			msg += "글 내용을 입력하세요.\n";
		
		if(!msg.equals("")) return msg; //내용이 없다면 메세지 전송
		
		log.info("msg : " + msg);
		
		log.info("update_boardNum : " + req.getParameter("update_boardNum"));
		log.info("update_boardName : " + req.getParameter("update_boardName"));
		log.info("update_boardSubject : " + req.getParameter("update_boardSubject"));
		log.info("update_boardContent : " + req.getParameter("update_boardContent"));
		
		log.info("fileName : " + file.getOriginalFilename());
		
		//기존 정보 가져오기
		BoardVO boardVO = new BoardVO();
		BoardVO oldBoardVO = boardSvc.getArticle(boardNum);
		boardVO = oldBoardVO;
		
		//게시글 수정
		boardVO.setBoardNum(boardNum);
		boardVO.setBoardName(req.getParameter("update_boardName"));
		boardVO.setBoardSubject(req.getParameter("update_boardSubject"));
		boardVO.setBoardContent(req.getParameter("update_boardContent"));
		
		// 주의) 편의상 다른 게시글에서도 동일한 첨부가 있을 경우 문제가 되므로 
	    //      기존 파일 삭제는 생략하였습니다. 이러한 경우는 파일 업로드시 계정별 폴더 세분화     
	    //      혹은 업로드 파일마다 접미사(순번 등) 등을 이용하여 처리할 수 있습니다.
		// 기존 파일과 비교
		if(file.getOriginalFilename()==null ||
		   file.getOriginalFilename().equals("")){
			
			//기존 파일 저장
			boardVO.setBoardFile(oldBoardVO.getBoardFile());			
		}else {
			boardVO.setBoardFile(file.getOriginalFilename());
			
			// 파일 저장소에 새 파일 저장
			if(!boardVO.getBoardFile().isEmpty() && file != null){//파일 유효성 점검
				String fileName = file.getOriginalFilename();
				
				//파일 저장소에 저장
				FileOutputStream fos = null;
				
				try{
					byte[] bytes = file.getBytes();
					
					File outFileName = new File(uploadDirResource.getPath() + fileName);
					fos = new FileOutputStream(outFileName);
					
					fos.write(bytes);
					
				}catch(IOException e){
					
					log.info("updateController file upload error");
					e.printStackTrace();
					
				}finally{
					try{
						if(fos != null) fos.close();
					}catch(IOException e){
						log.info("updateController update error");
						e.printStackTrace();
					}
					log.info("file upload success !");
					
				}//end finally
			}// 파일 업로드 처리 
		}
		
		String dateString = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(System.currentTimeMillis())).toString();
		
		log.info("업데이트 등록일 : " + dateString);
		boardVO.setBoardDate(dateString);
		
		log.info("boardVO : " + boardVO);
		
		boardSvc.updateBoard(boardVO);
		
		msg = "게시글을 성공적으로 수정하였습니다.";
		
		log.info(msg);
		
		return "redirect:/board/list.do/1?${_csrf.parameterName}=${_csrf.token}";
		//return "/board/qna_board_list";
	}
	
	@RequestMapping("/delete.do")
	@ResponseBody
	public String deleteBoard(@RequestParam("boardNum") int boardNum,
							  Model model){
		
		log.info("################################ DeleteBoard");
		log.info("Delete_boardNum : " + boardNum);
		
		boardSvc.deleteBoard(boardNum);
		
		
		log.info("게시글을 성공적으로 지웠습니다.");
		
		return "성공";

	}
	
/*	@RequestMapping("/delete.do")
	@ResponseBody
	public List<BoardVO> deleteBoard(@RequestParam("boardNum") int boardNum,
							  Model model){
		
		log.info("################################ DeleteBoard");
		log.info("Delete_boardNum : " + boardNum);
		
		boardSvc.deleteBoard(boardNum);
		int limit = boardSvc.getListCount();
		int page = 1;
		
		
		log.info("게시글을 성공적으로 지웠습니다.");
		
		return boardSvc.getArticleList(page, limit);

	}*/
	
	
	

}
