package kr.or.kosa;

import java.security.Principal;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home!");
		return "home";
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String loginhome(@RequestParam("userid") String userid, HttpSession session) {
	    logger.info("Welcome home!");
	    // 세션 객체를 가져옵니다.
	    session.setAttribute("userid", userid);
	    System.out.println("userid : " + userid);
	    // 홈 페이지로 이동합니다.
	    return "home";
	}
	
	@RequestMapping(value="/projectList.do")
	public String projectList() {
		logger.info("projectList으로 이동");
		return "project/projectList";
	}
	
	@RequestMapping(value="/projectDetail.do/{projectId}")
	public String projectList(@PathVariable("projectId") String projectId, HttpSession session) {
		logger.info("projectId으로 이동");
		session.setAttribute("projectId", projectId);
	    System.out.println("projectId : " + projectId);
		return "project/projectDetail";
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(HttpSession session) {
		logger.info("Logout으로 이동");
		session.removeAttribute("userid");
		return "home";
	}
	
	@GetMapping(value="/loginForm.do")
	public String login() {
		logger.info("LoginForm으로 이동");
		return "member/loginForm";
	}

	

}
