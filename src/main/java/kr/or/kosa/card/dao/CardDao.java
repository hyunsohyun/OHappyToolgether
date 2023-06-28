package kr.or.kosa.card.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.kosa.card.vo.Card;

public interface CardDao {
	// 칸반보드 select 인터페이스
	List<Card> selectByKanbanboardId(@Param("projectId") int projectId, @Param("kanbanboardId") int kanbanboardId);
	
	// 칸반보드 insert 인터페이스
	int insertCard(Card card);
	
	// 칸반보드 update 인터페이스
	int updateCard(Card card);
	
	// delete
	int deleteCard(int cardId);
}
