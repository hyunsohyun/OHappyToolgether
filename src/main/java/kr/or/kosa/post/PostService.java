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
	public List<Post> postlist(int boardId) {
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
	
	//프로젝트의 최신글 5개 가져오기
	public List<Post> recentPostList(int projectId){
		System.out.println("recentPostList(int projectId) 서비스 시작");
		List<Post> postList = null;
		try {
			PostDao postdao = sqlsession.getMapper(PostDao.class);
			postList = postdao.recentPostList(projectId);
		} catch(Exception e) {
			System.out.println("글목록 오류발생");
			System.out.println(e.getMessage());
		}
		return postList;
		
	}
	
	
	//상세보기
	public Post postDetail(Post postParam){
		Post post = null;
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			post = Postdao.postDetail(postParam);
		}catch (Exception e) {
			System.out.println("글상세 오류발생");
			System.out.println(e.getMessage());
		}

		return post;
	}

	//글쓰기
	public int postInsert(Post post){
		int postId = -1;
		
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			
			//생성된 postId			
			Postdao.postInsert(post);
			System.out.println("postID : " + post.getPostId());
			postId =  post.getPostId();
			
		}catch (Exception e) {
			System.out.println("글쓰기 오류발생");
			System.out.println(e.getMessage());
			e.getStackTrace();
		}

		return postId;
	}
	
	//수정하기
	public int postUpdate(Post post){
		int result = 0;
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			result = Postdao.postUpdate(post);
		}catch (Exception e) {
			System.out.println("글수정 오류발생");
			System.out.println(e.getMessage());
		}

		return result;
	}
	
	//삭제하기
	public int postDelete(Post post){
		int result = 0;
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			result = Postdao.postDelete(post);
		}catch (Exception e) {
			System.out.println("글삭제 오류발생");
			System.out.println(e.getMessage());
		}
		
		return result;
	}
	
	//조회수증가
	public void postHitUpdate(Post post) {
		try {
			PostDao Postdao = sqlsession.getMapper(PostDao.class);
			Postdao.postHitUpdate(post);
		}catch (Exception e) {
			System.out.println("조회수 업데이트 오류발생");
			System.out.println(e.getMessage());
		}
	}
}
