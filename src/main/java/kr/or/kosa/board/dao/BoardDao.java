package kr.or.kosa.board.dao;

import java.util.List;

import kr.or.kosa.board.vo.Board;

public interface BoardDao {

	int insertBoard(Board board);

	List<Board> selectBoardList(int projectId);

	int updateBoard(Board board);

	int deleteBoard(int boardId);
	
	String getBoardName(Board board);
}
