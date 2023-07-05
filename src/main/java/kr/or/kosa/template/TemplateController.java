package kr.or.kosa.template;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TemplateController {
	
	/* 게시판 템플릿 페이지*/
	@RequestMapping("/datatable.do")
	public String tables(Model model) throws Exception{
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
	
	@RequestMapping("/note.do")
	public String note() throws Exception{
		return "templateContent/summernote";
	}

}