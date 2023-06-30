package kr.or.kosa.card.vo;

import java.util.Date;


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
	public int getCardId() {
		return cardId;
	}
	public void setCardId(int cardId) {
		this.cardId = cardId;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public int getKanbanboardId() {
		return kanbanboardId;
	}
	public void setKanbanboardId(int kanbanboardId) {
		this.kanbanboardId = kanbanboardId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}
