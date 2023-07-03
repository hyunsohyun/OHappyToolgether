package kr.or.kosa.member.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.kosa.member.dao.UsersDao;
import kr.or.kosa.member.vo.Users;
import kr.or.kosa.project.dao.ProjectDao;

@Service
public class MemberService {
	
	SqlSession sqlsession;
	
	@Autowired
	public void setSqlSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
		System.out.println("sqlsession 생성됨 / 주소 : " + this.sqlsession);
	}
	
	public MemberService() {
		System.out.println("MemberService 생성자 호출됨");
	}
	
	public List<Users> selectAllUser(){
		UsersDao dao = sqlsession.getMapper(UsersDao.class);
		List<Users> list = null;
		try {
			list = dao.selectAllUser();
		} catch (Exception e) {
			System.out.println("selectAllUser에서 터짐");
			e.printStackTrace();
		}		
		return list;
	}
	
	public List<Users> selectAllUsersByProjectId(int projectId){
		System.out.println("selectAllUsersByProjectId() 시작");
		List<Users> list = null;
		UsersDao dao = sqlsession.getMapper(UsersDao.class);
		System.out.println("ProjectDao 맵퍼 가져옴");
		try {
			list = dao.selectAllUsersByProjectId(projectId);
			System.out.println("list 사이즈 : " + list.size());
			System.out.println("projectList 가져옴");
		} catch (Exception e) {
			System.out.println("dao.selectAllProjectById(userid) 에서 터짐");
			e.getStackTrace();
			System.out.println(e.getMessage());
		}		
		System.out.println("selectAllUsersByProjectId 리턴");
		return list;		
	}
	
	public List<Users> selectUserById(String userid) {
		UsersDao dao = sqlsession.getMapper(UsersDao.class);
		List<Users> list = null;
		try {
			list = dao.selectUserById(userid);
		} catch (Exception e) {
			System.out.println("selectUserById에서 터짐");
			e.printStackTrace();
		}		
		return list;
	}
	
	public int insertUser(Users user) {
		int result = 0;
		UsersDao dao = sqlsession.getMapper(UsersDao.class);
		try {
			result = dao.insertUser(user);
		} catch (Exception e) {
			System.out.println("insertUser에서 터짐");
			e.printStackTrace();
		}		
		return result;
	}
	
	public int deleteUser(String userid) {
		int result = 0;
		UsersDao dao = sqlsession.getMapper(UsersDao.class);
		try {
			result = dao.deleteUser(userid);
		} catch (Exception e) {
			System.out.println("deleteUser에서 터짐");
			e.printStackTrace();
		}		
		return result;		
	}
	
	public int updateUser(Users user) {
		int result = 0;
		UsersDao dao = sqlsession.getMapper(UsersDao.class);
		try {
			result = dao.updateUser(user);
		} catch (Exception e) {
			System.out.println("updateUser에서 터짐");
			e.printStackTrace();
		}		
		return result;
	}
	
}
