package kr.or.kosa.member.dao;

import java.util.List;

import kr.or.kosa.member.vo.Users;

public interface UsersDao {
	public List<Users> selectAllUser();
	public Users selectUserById(String userid);
	public int insertUser(Users user);
	public int deleteUser(String userid);
	public int updateUser(Users user);	
}
