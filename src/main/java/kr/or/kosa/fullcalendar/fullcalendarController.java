package kr.or.kosa.fullcalendar;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class fullcalendarController {
	@RequestMapping("/fullcalendar.do")
	public String tables(Model model) throws Exception{
		return "fullcalendar/fullcalendar";
	}
}
