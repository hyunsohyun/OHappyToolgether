package kr.or.kosa.project.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import kr.or.kosa.project.dao.ProjectDao;
import kr.or.kosa.project.vo.Project;
import kr.or.kosa.project.vo.UsersProject;

@Service
public class ProjectService {
	
	SqlSession sqlsession;
	
	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	public List<Project> selectAllProjectById(String userid){
		System.out.println("selectAllProjectById() 시작");
		List<Project> list = null;
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		System.out.println("ProjectDao 맵퍼 가져옴");
		try {
			list = dao.selectAllProjectById(userid);
			System.out.println("list 사이즈 : " + list.size());
			System.out.println("projectList 가져옴");
		} catch (Exception e) {
			System.out.println("dao.selectAllProjectById(userid) 에서 터짐");
			e.getStackTrace();
			System.out.println(e.getMessage());
		}		
		System.out.println("selectAllProjectById 리턴");
		return list;
	}
	
	public Project selectProjectByProjectId(int projectId){
		System.out.println("selectAllProjectById() 시작");
		Project project = null;
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		System.out.println("ProjectDao 맵퍼 가져옴");
		try {
			project = dao.selectProjectByProjectId(projectId);
			System.out.println("project 가져옴");
		} catch (Exception e) {
			System.out.println("selectProjectByProjectId(int projectId) 에서 터짐");
			e.getStackTrace();
			System.out.println(e.getMessage());
		}		
		System.out.println("selectAllProjectById 리턴");
		return project;
	}
	
	public int insertProject(Project project) {
		System.out.println("insertProject 서비스 시작");
		int result = 0;
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		System.out.println("ProjectDao 맵퍼 가져옴");
		try {
			result = dao.insertProject(project);
			System.out.println("insertProject 처리함");
		} catch (Exception e) {
			e.getStackTrace();
		}		
		return result;
	}
	
	public int deleteProject(String projectId) {
		int result = 0;
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		System.out.println("ProjectDao 맵퍼 가져옴");
		try {
			result = dao.deleteProject(projectId);
			System.out.println("deleteProject 처리함");
		} catch (Exception e) {
			e.getStackTrace();
		}		
		return result;
	}
	
	public int insertUsersProject(UsersProject usersProject) {
		int result = 0;
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		System.out.println("ProjectDao 맵퍼 가져옴");		
		System.out.println("userid : " + usersProject.getUserid());
		System.out.println("projectId : " + usersProject.getProjectId());
		try {			
			result = dao.insertUsersProject(usersProject);
			System.out.println("insertUsersProject 처리함");
		} catch (DataIntegrityViolationException e) {
	        System.out.println("기본 키 중복 오류가 발생했습니다.");
	        throw e;
	    } catch (Exception e) {
	        System.out.println("예외가 발생했습니다.");
	        throw new RuntimeException("insertUsersProject 메서드 실행 중 예외가 발생했습니다.", e);
	    }	
		return result;
	}
	
	public int deleteUsersProject(UsersProject usersProject) {
		int result = 0;
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		System.out.println("ProjectDao 맵퍼 가져옴");			
		try {			
			result = dao.deleteUsersProject(usersProject);
			System.out.println("deleteUsersProject 처리함");
		} catch (Exception e) {
			e.getStackTrace();
		}		
		return result;
	}
	
	public int deleteAllUsersProject(int projectId) {
		int result = 0;
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		System.out.println("ProjectDao 맵퍼 가져옴");			
		try {			
			result = dao.deleteAllUsersProject(projectId);
			System.out.println("deleteUsersProject 처리함");
		} catch (Exception e) {
			e.getStackTrace();
		}		
		return result;
	}
	
	//프로젝트 이름변경
	public int updateProjectName(Project project) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		return dao.updateProjectName(project);
	}
	
	
	public int updateProjectImg(Project project) {
		ProjectDao dao = sqlsession.getMapper(ProjectDao.class);
		return dao.updateProjectImg(project);
	}
}
