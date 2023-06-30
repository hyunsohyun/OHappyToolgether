package kr.or.kosa.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.kosa.board.dao.BoardDao;
import kr.or.kosa.board.vo.Board;

@Service
public class BoardService {

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}

	// 게시판 생성
	public int insertBoard(Board board) {
		BoardDao boardDao = sqlsession.getMapper(BoardDao.class);
		return boardDao.insertBoard(board);
	}

	// 게시판 전체조회
	public List<Board> selectBoardList(int projectId) {
		BoardDao boardDao = sqlsession.getMapper(BoardDao.class);
		List<Board> list = boardDao.selectBoardList(projectId);
		return list;
	}

	// 게시판 수정
	public int updateBoard(Board board) {
		BoardDao boardDao = sqlsession.getMapper(BoardDao.class);
		return boardDao.updateBoard(board);
	}

	// 게시판 삭제
	public int deleteBoard(int boardId) {
		BoardDao boardDao = sqlsession.getMapper(BoardDao.class);
		return boardDao.deleteBoard(boardId);
	}

}
