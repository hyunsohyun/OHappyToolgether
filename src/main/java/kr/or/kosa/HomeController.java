package kr.or.kosa;

import java.security.Principal;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.kosa.member.service.MemberService;
import kr.or.kosa.member.vo.Users;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	MemberService memberService;
	
	@Autowired
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, HttpSession session, Principal principal) {
		logger.info("Welcome home!");
		if(principal != null) {
			String userid = principal.getName();
			System.out.println("홈에 접속한 userid : " + userid);
			if(!userid.equals("anonymousUser")) {
				session.setAttribute("userid", userid);
			}
			
		}
		return "home";
	}

	@RequestMapping(value = "/loginForm")
	public String login() {
		logger.info("Welcome home!");
		return "member/loginForm";
	}

	@GetMapping(value = "/joinForm")
	public String join() {
		logger.info("joinForm으로 이동");
		return "member/joinForm";
	}
	
	@GetMapping(value = "/editForm")
	public String editForm(Model model, Principal principal) {
		logger.info("editForm으로 이동");
		String userid = principal.getName();
		System.out.println("editForm으로 이동");
		System.out.println("userid :" + userid);
		List<Users> list = null;
		try {
			list = memberService.selectUserById(userid);
			model.addAttribute("user", list.get(0));
		} catch (Exception e) {
			System.out.println("editForm에서 터짐");
			System.out.println(e.getMessage());
		}
		return "member/editForm";
	}
	
	

}
