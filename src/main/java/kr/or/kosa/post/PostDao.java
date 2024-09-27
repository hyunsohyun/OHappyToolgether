package kr.or.kosa.post;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface PostDao {
	//리스트
	public List<Post> postList(int postId) throws ClassNotFoundException, SQLException;
	
	//글상세
	public Post postDetail(Post post) throws ClassNotFoundException, SQLException;
	
	//글등록
	public int postInsert(Post post) throws ClassNotFoundException, SQLException;
	
	//글삭제
	public int postDelete(Post post) throws ClassNotFoundException, SQLException;
	
	//글수정
	public int postUpdate(Post post) throws ClassNotFoundException, SQLException;
	
	//게시판 조회수 업데이트
	public void postHitUpdate(Post post) throws ClassNotFoundException, SQLException;
	
	//최근 글 5개 가져오기
	public List<Post> recentPostList(int projectId) throws ClassNotFoundException, SQLException;
	
	//이전글 다음글 가지고오기 
	public Post nextPostInfo(Post post) throws ClassCastException, SQLException;
}
