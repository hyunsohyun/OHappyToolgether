package kr.or.kosa.post;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PostService {

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	public List<Post> postlist() {
		List<Post> postList = null;
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			postList = Postdao.postList();
		} catch(Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}
		return postList;
	}

}
