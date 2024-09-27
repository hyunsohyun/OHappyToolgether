package kr.or.kosa.comments;

import java.sql.SQLException;
import java.util.List;

public interface CommentsDao {
	
	public List<Comments> commentList(Comments comment) throws ClassNotFoundException, SQLException;
	public Comments commentDetail(Comments comment) throws ClassNotFoundException, SQLException;
	public int commentInsert(Comments comment) throws ClassNotFoundException, SQLException;
	public int commentUpdate(Comments comment) throws ClassNotFoundException, SQLException;
	public int commentDelete(Comments comment) throws ClassNotFoundException, SQLException;
}
