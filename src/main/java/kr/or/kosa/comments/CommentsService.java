package kr.or.kosa.comments;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentsService {

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	//댓글 리스트
	public List<Comments> commentList(Comments comment) {
		List<Comments> commentList = null;
		try {
			CommentsDao Commentsdao = sqlsession.getMapper(CommentsDao.class);
			commentList = Commentsdao.commentList(comment);
		} catch(Exception e) {
			System.out.println("댓글 리스트 오류발생");
			System.out.println(e.getMessage());
		}
		return commentList;
	}
	
	//댓글 상세
	public Comments commentDetail(Comments comment){
		Comments Comments = null;
		try {
			//댓글정보 테이블 등록
			CommentsDao commentsdao = sqlsession.getMapper(CommentsDao.class);
			Comments = commentsdao.commentDetail(comment);
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return Comments;
	}

	//댓글쓰기
	public int commentInsert(Comments comments){
		int result = 0;
		try {
			CommentsDao commentsdao = sqlsession.getMapper(CommentsDao.class);
			result = commentsdao.commentInsert(comments);
		}catch (Exception e) {
			System.out.println("댓글쓰기 오류발생");
			System.out.println(e.getMessage());
		}
		return result;
	}
	
	//댓글수정
	public int commentUpdate(Comments comments){
		int result = 0;
		
		try {
			CommentsDao Commentsdao = sqlsession.getMapper(CommentsDao.class);
			result = Commentsdao.commentUpdate(comments);
			
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return result;
	}
	
	//댓글삭제
	public int commentDelete(Comments comments){
		int result = 0;
		
		try {
			CommentsDao commentsdao = sqlsession.getMapper(CommentsDao.class);
			result = commentsdao.commentDelete(comments);
			
		}catch (Exception e) {
			System.out.println("댓글 삭제 오류발생");
			System.out.println(e.getMessage());
		}

		return result;
	}
}
