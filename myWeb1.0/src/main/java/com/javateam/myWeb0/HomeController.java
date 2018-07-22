package com.javateam.myWeb0;



import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.CollectionType;
import com.javateam.service.AuthJdbcService;
import com.javateam.springBoard.service.BoardService;
import com.javateam.springBoard.vo.BoardVO;
import com.javateam.springBoard.vo.PageInfo;
import com.javateam.vo.IdParseVO;
import com.javateam.vo.NameParseVO;
import com.javateam.vo.Users;

import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	
	
	@Autowired
	AuthJdbcService authJdbcService;
	
	@Autowired
	private BoardService boardSvc;
	
	@RequestMapping("/")
	public String mainhome(){
		return "/index";
	}
	
	@RequestMapping("/index")
	public void index(){
		
	}
	
	@RequestMapping("/mainpage")
	public void mainpage(){
		
	}
	@RequestMapping("/login")
	public String loginhome(){
		return "redirect:/login/login";
		
	}
	
	
	@RequestMapping("/welcome")
	public void welcome(){
		
		
	}
	
	@RequestMapping("/join")
	public void join(){
		log.info("/join");
		
		
	}
	
	@RequestMapping("/joinAction")
	public void join(@RequestParam("userid") String userid,
					@RequestParam("userpw") String userpw,
					@RequestParam("userpw2") String userpw2,
					@RequestParam("username") String username,
					@RequestParam("lolname") String lolname){
		
		log.info("/joinAction");
		
		String hashedPassword = "";
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		hashedPassword = passwordEncoder.encode(userpw);
		
		System.out.println(hashedPassword);
		
        String dateString
        = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
             .format(new Date(System.currentTimeMillis())).toString();
   
        System.out.println(dateString);
		
		Users users = new Users(userid, username, hashedPassword, "ROLE_USER", dateString, 1, lolname);
		
		authJdbcService.insertUsers(users);

		
	}
	@RequestMapping("/searchSubmit")
	public void searchSubmit(){
		
	}
	
	@RequestMapping("/search")
	public String searchParse(Model model,
							  @RequestParam("sumName") String sumname) throws UnsupportedEncodingException{
		
		String api_key="RGAPI-9d035a68-8c30-4e39-ab05-66464cea3212";
		
		String gamename = sumname;
		
		String gamename_Decode = URLDecoder.decode(gamename, "UTF-8");
		
		String url = "https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/"
					  +gamename_Decode+"?api_key="+api_key;
		
		RestTemplate restTemplate = new RestTemplate();
		ObjectMapper objMapper = new ObjectMapper();
		
		String resultStr = "";
		
		resultStr = restTemplate.getForObject(url, String.class);
		
		try {
			//Collection<NameParseVO> nameParse = objMapper.readValue(resultStr, new TypeReference<Collection<NameParseVO>>() { });
			//NameParseVO[] nameParse = objMapper.readValue(resultStr, NameParseVO[].class);
			NameParseVO nameParse = objMapper.readValue(resultStr, NameParseVO.class);
			log.info("resultStr" + resultStr);
			model.addAttribute("result", nameParse);
			log.info("List : " + nameParse);
			long summonerid = nameParse.getId();
			
			List<IdParseVO> idparseList
	            = new ArrayList<IdParseVO>();
			
			String url2 = "https://kr.api.riotgames.com/lol/league/v3/positions/by-summoner/"
						  +summonerid+"?api_key="+api_key;
			log.info("########################################################## 1번 try");
			try{
/*				long summonerid = nameParse.getId();
				
				List<IdParseVO> idparseList
		            = new ArrayList<IdParseVO>();
				
				String url2 = "https://kr.api.riotgames.com/lol/league/v3/positions/by-summoner/"
							  +summonerid+"?api_key="+api_key;*/
				resultStr = restTemplate.getForObject(url2, String.class);
			/*	if(resultStr.equals("[]")){ result 값이 없을경우 IOException 으로보내서 처리를 해도됨.
					log.info("################################################## if resultStr 없음");
					
					throw new IOException();
				}*/
				/*HashSet<IdParseVO> idParse = (HashSet<IdParseVO>) objMapper.readValue(resultStr, IdParseVO.class);*/
				
				CollectionType javaType = objMapper.getTypeFactory()
		                  .constructCollectionType(List.class, IdParseVO.class);
				
				idparseList = objMapper.readValue(resultStr, javaType);
				
				if(idparseList.size() == 1){
					if(idparseList.get(0).getQueueType().equals("RANKED_SOLO_5x5")){
						model.addAttribute("resultSolo", idparseList.get(0));
						model.addAttribute("modelSize", idparseList.size());
					}else if(idparseList.get(0).getQueueType().equals("RANKED_FLEX_SR")){
						model.addAttribute("resultTeam", idparseList.get(0));
						model.addAttribute("modelSize", idparseList.size());
					}
				}else if(idparseList.size() == 2){
					if(idparseList.get(0).getQueueType().equals("RANKED_SOLO_5x5")){
						model.addAttribute("resultSolo", idparseList.get(0));
						model.addAttribute("resultTeam", idparseList.get(1));
					}
					else{
						model.addAttribute("resultTeam", idparseList.get(0));
						model.addAttribute("resultSolo", idparseList.get(1));
					}
				}else{
					model.addAttribute("unranked", 0);
					model.addAttribute("msg", "레벨이 30이 아니거나 솔랭, 팀랭 둘 다 게임 수가 부족합니다.");
					return "/searchSubmit";
				}

				return "/search";
			}catch(IOException e){
				System.out.println("id parse error");
				/*e.printStackTrace();*/
				return "/searchSubmit";
			}
			
		} catch (IOException e) {
			System.out.println("name parse error");
			
			e.printStackTrace();
		}
		
		return "/search";
		
	}
	
	@RequestMapping("/admin/adminpage")
	public String adminpage(Model model){
		int page = 1;
		int limit = boardSvc.getListCount();;
		
		List<BoardVO> articleList;
		
		int listCount = boardSvc.getListCount();
		
		articleList = boardSvc.getArticleList(page, limit);
		log.info("admon Controller articleList : " + articleList);
		log.info("admin Controller listcount :" + listCount);
		
		//총 페이지 수.
   		int maxPage=(int)((double)listCount/limit);
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
		
		return "/admin/adminPage";
	}
	
	
}