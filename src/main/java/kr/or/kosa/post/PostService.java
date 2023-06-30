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
	public List<Post> postlist(String boardId) {
		List<Post> postList = null;
		try {
			PostDao postdao = sqlsession.getMapper(PostDao.class);
			postList = postdao.postList(boardId);
		} catch(Exception e) {
			System.out.println("글목록 오류발생");
			System.out.println(e.getMessage());
		}
		return postList;
	}
	
	//상세보기
	public Post postDetail(int postId){
		Post post = null;
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			post = Postdao.postDetail(postId);
		}catch (Exception e) {
			System.out.println("글상세 오류발생");
			System.out.println(e.getMessage());
		}

		return post;
	}

	//글쓰기
	public String postInsert(Post post){
		String message = "";
		
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			int n = Postdao.postInsert(post);
			if(n>0) {
				message = "글쓰기 성공";
			}else {
				message = "글쓰기 실패";
			}
		}catch (Exception e) {
			System.out.println("글쓰기 오류발생");
			System.out.println(e.getMessage());
			e.getStackTrace();
		}

		return message;
	}
	
	//수정하기
	public String postUpdate(Post post){
		String message = "";
		
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			int n = Postdao.postUpdate(post);
			if(n>0) {
				message = "수정 성공";
			}else {
				message = "수정 실패";
			}
		}catch (Exception e) {
			System.out.println("글수정 오류발생");
			System.out.println(e.getMessage());
		}

		return message;
	}
	
	//삭제하기
	public String postDelete(int postId){
		String message = "";
		
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			int n = Postdao.postDelete(postId);
			if(n>0) {
				message = "삭제 성공";
			}else {
				message = "삭제 실패 ";
			}
		}catch (Exception e) {
			System.out.println("글삭제 오류발생");
			System.out.println(e.getMessage());
		}
		
		return message;
	}
	
	public void postHitUpdate(int postId) {
		
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			Postdao.postHitUpdate(postId);
		}catch (Exception e) {
			System.out.println("조회수 업데이트 오류발생");
			System.out.println(e.getMessage());
		}
		
	}
}
