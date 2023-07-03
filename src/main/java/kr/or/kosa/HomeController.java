package kr.or.kosa;

import java.security.Principal;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.kosa.project.service.ProjectService;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	ProjectService projectService;

	@Autowired
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home!");
		return "home";
	}

	@RequestMapping(value = "/loginForm")
	public String login() {
		logger.info("Welcome home!");
		return "member/loginForm";
	}

	@RequestMapping(value = "/login")
	public String loginhome(HttpSession session, Principal principal) {
		System.out.println("로그인 성공");
		System.out.println("userid : " + principal.getName());
		session.setAttribute("userid",principal.getName());
		return "member/loginForm";
	}


	@GetMapping(value = "/joinForm")
	public String join() {
		logger.info("joinForm으로 이동");
		return "member/joinForm";
	}
	
	@GetMapping(value = "/editForm")
	public String editForm() {
		logger.info("editForm으로 이동");
		return "member/editForm";
	}
	
	

}
