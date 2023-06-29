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
	public List<Comments> commentList(int postId) {
		List<Comments> commentList = null;
		try {
			CommentsDao Commentsdao = sqlsession.getMapper(CommentsDao.class);
			commentList = Commentsdao.commentList(postId);
		} catch(Exception e) {
			System.out.println("댓글 리스트 오류발생");
			System.out.println(e.getMessage());
		}
		return commentList;
	}
	
	//댓글 상세
	public Comments commentDetail(String commentId){
		Comments Comments = null;
		try {
			//댓글정보 테이블 등록
			CommentsDao commentsdao = sqlsession.getMapper(CommentsDao.class);
			Comments = commentsdao.commentDetail(commentId);
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return Comments;
	}

	//댓글쓰기
	public Comments commentInsert(Comments comments){
		try {
			CommentsDao commentsdao = sqlsession.getMapper(CommentsDao.class);
			int n = commentsdao.commentInsert(comments);
			if(n>0) {
				System.out.println("댓글쓰기 성공");
			}else {
				System.out.println("댓글쓰기 실패 ");
			}
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return comments;
	}
	
	//댓글수정
	public Comments commentUpdate(Comments comments){
		try {
			CommentsDao Commentsdao = sqlsession.getMapper(CommentsDao.class);
			int n = Commentsdao.commentUpdate(comments);
			if(n>0) {
				System.out.println("댓글수정 성공");
			}else {
				System.out.println("댓글수정 실패 ");
			}
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return comments;
	}
	
	//댓글삭제
	public Comments commentDelete(Comments comments){
		try {
			CommentsDao commentsdao = sqlsession.getMapper(CommentsDao.class);
			int n = commentsdao.commentDelete(comments);
			if(n>0) {
				System.out.println("댓글삭제 성공");
			}else {
				System.out.println("댓글삭제 실패 ");
			}
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return comments;
	}
}
