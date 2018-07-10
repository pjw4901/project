package com.javateam.myWeb0;



import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.type.CollectionType;
import com.javateam.service.AuthJdbcService;
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
	
	@RequestMapping("/")
	public String mainhome(){
		return "redirect:/html/index.html";
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
		
		String api_key="RGAPI-0cd68ae4-29fc-4d22-8532-983222c49b92";
		
		String gamename = sumname;
		
		String gamename_Decode = URLDecoder.decode(gamename, "UTF-8");
		
		//String url = "https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/%EC%A0%95%EA%B8%80%EB%A1%9C%EB%8B%A4%EC%9D%B4%EC%95%84%EA%B0%84%EB%8B%A4?api_key=RGAPI-ff444727-9804-4874-83a4-0c88ed8905ac";
		String url = "https://kr.api.riotgames.com/lol/summoner/v3/summoners/by-name/"
					  +gamename_Decode+"?api_key="+api_key;
		System.out.println(gamename_Decode);
		System.out.println("url : " + url);
		
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
			System.out.println(nameParse.getId());
			
			try{
				long summonerid = nameParse.getId();
				
				List<IdParseVO> idparseList
		            = new ArrayList<IdParseVO>();
				
				String url2 = "https://kr.api.riotgames.com/lol/league/v3/positions/by-summoner/"
							  +summonerid+"?api_key="+api_key;
				resultStr = restTemplate.getForObject(url2, String.class);
				log.info("resultStr2" + resultStr);
				
				CollectionType javaType = objMapper.getTypeFactory()
		                  .constructCollectionType(List.class, IdParseVO.class);
				
				/*HashSet<IdParseVO> idParse = (HashSet<IdParseVO>) objMapper.readValue(resultStr, IdParseVO.class);*/
				idparseList = objMapper.readValue(resultStr, javaType);
				//model.addAttribute("result2", idparseList.get(0));
				log.info("idParse : " + idparseList.get(0));
				log.info("idParse : " + idparseList.size());
				
				if(idparseList.size() == 1){
					if(idparseList.get(0).getQueueType().equals("RANKED_SOLO_5x5")){
						model.addAttribute("resultSolo", idparseList.get(0));
						model.addAttribute("modelSize", idparseList.size());
					}else if(idparseList.get(0).getQueueType().equals("RANKED_FLEX_SR")){
						model.addAttribute("resultTeam", idparseList.get(0));
						model.addAttribute("modelSize", idparseList.size());
						log.info("else if");
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
					model.addAttribute("unranked", nameParse);
				}

				return "/search";
			}catch(Exception e){
				System.out.println("id parse error");
				e.printStackTrace();
			}
			
		} catch (IOException e) {
			System.out.println("name parse error");
			e.printStackTrace();
		}
		
		return "/search";
		//log.info("parseList : " + parseList);
		
		//List<NameParseVO> result = parseList.getParseList();
		
		//log.info("result : " + result);
		
		//model.addAttribute("result", result);
		
	}
	
}
