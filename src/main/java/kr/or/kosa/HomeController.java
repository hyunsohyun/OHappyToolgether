package kr.or.kosa;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home!");
		return "home";
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String loginhome(Locale locale, Model model) {
		logger.info("Welcome home!");
		return "home";
	}
	
	public HomeController() {
		System.out.println("홈컨트롤러 생성자 호출");
	}
	
	@GetMapping(value="/loginForm.do")
	public String login() {
		logger.info("LoginForm으로 이동");
		return "member/loginForm";
	}

	@GetMapping(value="/logout.do")
	public String logout() {
		logger.info("Logout으로 이동");
		return "member/logout";
	}

}
