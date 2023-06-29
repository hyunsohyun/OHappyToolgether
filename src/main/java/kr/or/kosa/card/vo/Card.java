package kr.or.kosa.card.vo;

import java.util.Date;

import lombok.Data;

/*
CREATE TABLE card (
	card_id NUMBER NOT NULL,  		카드 ID 
	project_id NUMBER NOT NULL,  	프로젝트 ID 
	kanbanboard_id NUMBER,  		칸반보드 ID 
	title VARCHAR2(100),  			제목 
	content VARCHAR2(4000),  		내용 
	
	create_date DATE,  				작성날짜 
	start_date DATE,  				시작날짜 
	end_date DATE,  				종료날짜 
	name VARCHAR2(100)  			담당자 이름 
);
*/

@Data
public class Card {
	private int cardId;
	private int projectId;
	private int kanbanboardId;
	private String title;
	private String content;
	
	private Date createDate;
	private Date startDate;
	private Date endDate;
	private String name;
}
