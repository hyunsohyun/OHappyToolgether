package kr.or.kosa.template;

public class Board {
	private String boardId;
	private String boardName;
	private String projectId;
	
	public String getBoardId() {
		return boardId;
	}
	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	
	@Override
	public String toString() {
		return "Board [boardId=" + boardId + ", boardName=" + boardName + ", projectId=" + projectId + "]";
	}
	
	
	
}
