package kr.or.kosa.post;

import java.sql.SQLException;
import java.util.List;

public interface PostDao {
	
	public List<Post> postList() throws ClassNotFoundException, SQLException;
}
