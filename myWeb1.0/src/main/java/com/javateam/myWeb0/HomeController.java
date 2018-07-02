package com.javateam.myWeb0;



import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.javateam.service.AuthJdbcService;
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
					@RequestParam("username") String username){
		
		log.info("/joinAction");
		
		String hashedPassword = "";
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		hashedPassword = passwordEncoder.encode(userpw);
		
		System.out.println(hashedPassword);
		
        String dateString
        = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
             .format(new Date(System.currentTimeMillis())).toString();
   
        System.out.println(dateString);
		
		Users users = new Users(userid, username, hashedPassword, "ROLE_USER", dateString, 1);
		
		authJdbcService.insertUsers(users);

		
	}
	
	@RequestMapping("/search")
	public void searchParse(Model model) throws UnsupportedEncodingException{
		
		String api_key="RGAPI-ff444727-9804-4874-83a4-0c88ed8905ac";
		
		String gamename = "정글로다이아간다";
		
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
			model.addAttribute("result", nameParse);
			log.info("List : " + nameParse);
			System.out.println(nameParse.getAccountId());
		} catch (IOException e) {
			System.out.println("parse error");
			e.printStackTrace();
		}
		
		//log.info("parseList : " + parseList);
		
		//List<NameParseVO> result = parseList.getParseList();
		
		//log.info("result : " + result);
		
		//model.addAttribute("result", result);
		
	}
	
}
