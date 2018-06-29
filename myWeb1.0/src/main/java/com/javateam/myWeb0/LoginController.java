package com.javateam.myWeb0;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.javateam.service.AuthJdbcService;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	AuthJdbcService authJdbcService;
	
	@RequestMapping(value = "/admin/**", 
				method = RequestMethod.GET)
	public ModelAndView adminPage() {
	
		ModelAndView model = new ModelAndView();
		model.addObject("title", "Spring Security Password Encoder");
		model.addObject("message", "This page is for ROLE_ADMIN only!");
		model.setViewName("admin");
		
		return model;
	
	}
	
	@RequestMapping(value = "/secured/**",
			method = RequestMethod.GET)
	public String userPage() {
	
	return "/secured/welcome";

}
	
	/*@RequestMapping("/login")
	public ModelAndView login(@RequestParam(value="error", required = false) String error,
							  @RequestParam(value="logout", required = false) String logout){
		
		System.out.println("login msg!");
		
		ModelAndView model = new ModelAndView();
		
		if (error != null) {
			model.addObject("error", "Invalid username and password!");
		}

		if (logout != null) {
			model.addObject("msg", "You've been logged out successfully.");
		}
		
		model.setViewName("login");
		
		return model;
		
	}*/
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
    public String login(ModelMap model) {
    	
    	return "login";
    }
	
	@RequestMapping("/idCheck")
	public String idCheck(@RequestParam("username") String userid,
							Model model){
		
		System.out.println(userid);
		
		boolean flag = authJdbcService.hasUserid(userid);
		System.out.println(flag);
		model.addAttribute("flag", flag);
		
		return "idCheck";
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logout(ModelMap model,
    					 HttpServletRequest request,
    					 HttpServletResponse response) {
    	
	    Authentication auth 
		    	= SecurityContextHolder.getContext()
		    						   .getAuthentication();
	    
	    // System.out.println("auth : "+auth);
	    
	    // logout !
	    if (auth != null){    
	        new SecurityContextLogoutHandler().logout(request, response, auth);
	    }
	    
	    

	    return "logout";
    }
	
	@RequestMapping(value="/loginError", method = RequestMethod.GET)
    public String loginError(ModelMap model) {
    	
	    model.addAttribute("error", "true");
	    model.addAttribute("msg", "로그인 인증 정보가 잘못되었습니다.");
	    
	    return "login";
    }
    
    @RequestMapping("/access-denied")
    public String accessDenied() {
    	
    	System.out.println("403");
    	
    	return "redirect:/login";
    }
}
