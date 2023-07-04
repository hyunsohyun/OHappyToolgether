package kr.or.kosa.project.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.kosa.board.service.BoardService;
import kr.or.kosa.board.vo.Board;
import kr.or.kosa.member.service.MemberService;
import kr.or.kosa.member.vo.Users;
import kr.or.kosa.project.service.ProjectService;
import kr.or.kosa.project.vo.Project;

@Controller
public class ProjectViewController {
	
	ProjectService projectService;
	
	@Autowired
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}
	
	BoardService boardService;
	
	@Autowired
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}
	
	@RequestMapping("/projectManagement.do")
	public String projectManagementView() throws Exception{
		return "project/projectManagement";
	}

	MemberService memberService;
	
	@Autowired
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@RequestMapping(value="/projectList.do")
	public String projectList(Principal principal, HttpSession session) {
		System.out.println("projectList으로 이동");
		System.out.println("Request Mapping \"/projectList.do\"");
		List<Project> list = null;
		try {
			list = projectService.selectAllProjectById(principal.getName());
			session.setAttribute("projectList", list);
		} catch (Exception e) {
			System.out.println("projectList()에서 터짐");
			System.out.println(e.getMessage());
		}
		return "project/projectList";
	}
	
	@RequestMapping(value="/projectDetail.do/{projectId}")
	public String projectList(@PathVariable("projectId") int projectId, Principal principal, HttpSession session) {
		System.out.println("projectId "+projectId+"으로 이동");
		System.out.println("Request Mapping \"/projectDetail.do/{projectId}\"");
		System.out.println("projectId : " + projectId);
		Project project = projectService.selectProjectByProjectId(projectId);
		Users user = memberService.selectUserById(principal.getName()).get(0);
		
		String managerId = project.getManagerId();
		System.out.println("managerId : " + managerId);
		
		session.setAttribute("project", project);
		session.setAttribute("user", user);
		session.setAttribute("managerId", managerId);
		session.setAttribute("projectId", projectId);
		List<Board> list = null;
		try {
			list = boardService.selectBoardList(projectId);
			session.setAttribute("boardList", list);
		} catch (Exception e) {
			System.out.println("projectList()에서 터짐");
			System.out.println(e.getMessage());
		}
		
		return "project/projectDetail";
	}
	
	@RequestMapping(value="/insertProject")
	public String insertProject(HttpSession session, @RequestBody Project project) {
		System.out.println("@RequestMapping(value=\"/insertProject\") 진입");
		int result = 0;
		try {
			result = projectService.insertProject(project);
			System.out.println("프로젝트 삽입 : "+ result);
		} catch (Exception e) {
			System.out.println("insertProject()에서 터짐");
			System.out.println(e.getMessage());
		}
		return "project/projectList";
	}
}
