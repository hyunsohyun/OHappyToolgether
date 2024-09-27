package kr.or.kosa.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.kosa.card.vo.Card;
import kr.or.kosa.project.service.ProjectService;
import kr.or.kosa.project.vo.Project;
import kr.or.kosa.project.vo.UsersProject;

@RestController
@RequestMapping("/project")
public class ProjectController {
	
	ProjectService projectService;
	
	@Autowired
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}	
	
	@GetMapping({"{userid}"})
	public ResponseEntity<List<Project>> selectAllProjectById(@PathVariable("userid") String userid){
		List<Project> list = null;
		try {
			list = projectService.selectAllProjectById(userid);
			return new ResponseEntity<List<Project>>(list,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("selectAllProjectById()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<List<Project>>(list,HttpStatus.BAD_REQUEST);
		}		
	}

	
	@PostMapping
	public ResponseEntity<Integer> insertProject(@RequestBody Project project) {
		int result = 0;
		try {
			result = projectService.insertProject(project);
			System.out.println("requestBody의 project 정보 : " + project.toString());
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("insertProject()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@DeleteMapping("{projectId}")
	public ResponseEntity<Integer> deleteUser(@PathVariable("projectId") String projectId) {
		int result = 0;
		try {
			result = projectService.deleteProject(projectId);
			System.out.println("삭제 요청에 따라 다음 행의 개수가 삭제됨 : "+result);			
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("deleteUser()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@PostMapping("{projectId}/{userid}")
	public ResponseEntity<Integer> insertUsersProject(@RequestBody UsersProject usersProject) {
	    int result = 0;
	    System.out.println("PostMapping {projectId}/{userid}");
	    try {    
	        result = projectService.insertUsersProject(usersProject);
	        return new ResponseEntity<Integer>(result, HttpStatus.OK);
	    } catch (Exception e) {            
	        System.out.println("insertUsersProject()에서 예외가 발생했습니다.");
	        System.out.println(e.getMessage());
	        return new ResponseEntity<Integer>(result, HttpStatus.INTERNAL_SERVER_ERROR);
	    }        
	}
	
	@PostMapping("/insertProject")
	public String insertProject(HttpSession session, @RequestBody Project project) {
		System.out.println("@RequestMapping(value=\"/insertProject\") 진입");
		int result = 0;
		String userid = (String)session.getAttribute("userid");
		String projectId = "null값";
		try {
			result = projectService.insertProject(project);
			System.out.println("프로젝트 삽입행 : "+ result);
			projectId = String.valueOf(project.getProjectId());
			System.out.println("삽입한 projectId : "+ project.getProjectId());			
			if(result > 0) {
				session.setAttribute("projectList", projectService.selectAllProjectById(userid));
				System.out.println("세션의 프로젝트 리스트 갱신");
			}
		} catch (Exception e) {
			System.out.println("insertProject()에서 터짐");
			System.out.println(e.getMessage());
		}
		return projectId;
	}
	
	@DeleteMapping("{projectId}/{userid}")
	public ResponseEntity<Integer> deleteUsersProject(@RequestBody UsersProject usersProject) {
		int result = 0;
		System.out.println("DeleteMapping {projectId}/{userid}");
		try {	
			result = projectService.deleteUsersProject(usersProject);
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (DuplicateKeyException e) {
	        System.out.println("기본키 중복 오류 발생");
	        System.out.println(e.getMessage());
	        return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
	    }catch (Exception e) {			
			System.out.println("deleteUsersProject()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	//프로젝트 삭제
	@DeleteMapping("delete/{projectId}")
	public ResponseEntity<Integer> deleteAllUsersProject(@PathVariable int projectId, HttpSession session) {
	    int result = 0;
	    System.out.println("DeleteMapping {projectId}");
	    try {
	        // projectId를 사용하여 프로젝트 삭제 작업 수행
	        result = projectService.deleteAllUsersProject(projectId);
	        session.removeAttribute("boardList");
	        session.removeAttribute("managerId");
	        session.removeAttribute("projectId");
	        return new ResponseEntity<Integer>(result, HttpStatus.OK);
	    } catch (DuplicateKeyException e) {
	        System.out.println("기본키 중복 오류 발생");
	        System.out.println(e.getMessage());
	        return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
	    } catch (Exception e) {
	        System.out.println("deleteUsersProject()에서 예외 발생");
	        System.out.println(e.getMessage());
	        return new ResponseEntity<Integer>(result, HttpStatus.BAD_REQUEST);
	    }
	}

	
	//프로젝트 이름변경
	@PutMapping("{projectId}/{memberId}")
	public ResponseEntity<Map<String, String>> update(@RequestBody Project project, @PathVariable("projectId") int projectId, @PathVariable("memberId") String memberId ) {
		Map<String, String> response = new HashMap<String, String>();
		project.setProjectId(projectId);
		project.setManagerId(memberId);
		try {
			System.out.println("프로젝트 update 컨트롤러 실행");
			System.out.println(project.toString());
			
			projectService.updateProjectName(project);
			
			System.out.println("업데이트 실행 완료");
			response.put("message", "update success");
			return new ResponseEntity<Map<String, String>>(response, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String, String>>(response, HttpStatus.BAD_REQUEST); 
		}
	}
	
	//프로젝트 이미지 변경
	@PutMapping("projectImg/{projectId}")
	public ResponseEntity<Map<String, String>> updateProjectImage(@RequestBody Project project, @PathVariable("projectId") int projectId, HttpSession session) {
	    Map<String, String> response = new HashMap<>();
	    project.setProjectId(projectId);
	    try {
	        System.out.println(project.toString());
	        projectService.updateProjectImg(project);
	        Project projectsession = (Project)session.getAttribute("project");
	        projectsession.setProjectImage(project.getProjectImage());
	        session.setAttribute("project", projectsession);
	        
	        response.put("message", "update success");
	        return new ResponseEntity<>(response, HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("message", "update failure");
	        return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	    }
	}

	
	
	
	
	
	
}

