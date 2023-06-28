package kr.or.kosa.card.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.kosa.card.dao.CardDao;
import kr.or.kosa.card.vo.Card;

@Service
public class CardService {
	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	// 칸반보드 select 서비스
	public List<Card> selectByBoardSq(int projectId, int kanbanboardId){
	    List<Card> list = new ArrayList<Card>();
	    try {
	        CardDao carddao = sqlsession.getMapper(CardDao.class);
	        list = carddao.selectByKanbanboardId(projectId, kanbanboardId);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	// 칸반보드 insert 서비스
	public int insertCard(Card card) {
		CardDao carddao = sqlsession.getMapper(CardDao.class);
		return carddao.insertCard(card);
	}
	
	// 칸반보드 update 서비스
	public int updateCard(Card card) {
		CardDao carddao = sqlsession.getMapper(CardDao.class);
		return carddao.updateCard(card);
	}
	
	// 칸반보드 delete 서비스
	public int deleteCard(int cardId) {
		CardDao carddao = sqlsession.getMapper(CardDao.class);
		return  carddao.deleteCard(cardId);
	}
}
