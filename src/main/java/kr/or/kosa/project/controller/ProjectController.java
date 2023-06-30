package kr.or.kosa.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("insertUsersProject()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@DeleteMapping("{projectId}/{userid}")
	public ResponseEntity<Integer> deleteUsersProject(@RequestBody UsersProject usersProject) {
		int result = 0;
		System.out.println("DeleteMapping {projectId}/{userid}");
		try {	
			result = projectService.deleteUsersProject(usersProject);
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("deleteUsersProject()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	
	
	
}

