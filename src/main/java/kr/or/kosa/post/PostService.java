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

	//리스트
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
	
	//상세보기
	public Post postDetail(String postId){
		Post post = null;
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			post = Postdao.postDetail(postId);
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return post;
	}

	//수정하기
	
	//삭제하기
	
}
