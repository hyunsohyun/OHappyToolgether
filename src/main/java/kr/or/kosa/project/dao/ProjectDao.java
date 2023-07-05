package kr.or.kosa.project.dao;

import java.util.List;

import kr.or.kosa.project.vo.Project;
import kr.or.kosa.project.vo.UsersProject;

public interface ProjectDao {
	public List<Project> selectAllProjectById(String userid);	
	public Project selectProjectByProjectId(int projectId);
	public int insertProject(Project project);
	public int deleteProject(String projectId);
	public int insertUsersProject(UsersProject usersProject);
	public int deleteUsersProject(UsersProject usersProject);
	public int deleteAllUsersProject(int projectId);
	
	//프로젝트명 변경
	public int updateProjectName(Project project);
	public int updateProjectImg(Project project);
}
