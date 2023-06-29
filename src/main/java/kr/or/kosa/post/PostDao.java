package kr.or.kosa.post;

import java.sql.SQLException;
import java.util.List;

public interface PostDao {
	//리스트
	public List<Post> postList(String postId) throws ClassNotFoundException, SQLException;
	
	//글상세
	public Post postDetail(int postId) throws ClassNotFoundException, SQLException;
	
	//글등록
	public int postInsert(Post post) throws ClassNotFoundException, SQLException;
	
	//글삭제
	public int postDelete(int postId) throws ClassNotFoundException, SQLException;
	
	//글수정
	public int postUpdate(Post post) throws ClassNotFoundException, SQLException;
}
