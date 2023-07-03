package kr.or.kosa.kanban;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class KanbanController {
	@RequestMapping("/kanban.do")
	public String tables(Model model) throws Exception{
		return "kanban/kanban";
	}
}
