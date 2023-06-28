package kr.or.kosa.template;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TemplateController {

	private static final Logger logger = LoggerFactory.getLogger(TemplateController.class);
	
	/*템플릿 페이지들*/
	@RequestMapping("/board.do")
	public String tables() throws Exception{
		return "templateContent/datatable";
	}
	
	@RequestMapping("/chart.do")
	public String chart() throws Exception{
		return "templateContent/charts";
	}
	
	@RequestMapping("/calendar.do")
	public String calendarView() throws Exception{
		return "templateContent/fullCalendar";
	}

}
