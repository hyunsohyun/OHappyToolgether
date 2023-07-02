package kr.or.kosa;

import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home!");
		return "home";
	}

	@RequestMapping(value = "/loginForm.do")
	public String login() {
	    logger.info("Welcome home!");
	    return "member/loginForm";
	}
	
	@RequestMapping(value = "/login.do")
	public String loginhome(@RequestParam("userid") String userid, HttpSession session) {
	    logger.info("Welcome home!");
	    return "member/loginForm";
	}

	
	@GetMapping(value="/joinForm.do")
	public String join() {
		logger.info("joinForm으로 이동");
		return "member/joinForm";
	}

}
