package kr.or.kosa.post;


public class Post {
	private int postId;
	private int boardId;
	private String title;
	private String content;
	private int hit;
	private String createDate;
	private String modifyDate;
	private int projectId;
	private String userid;
	private String boardName;
	private String writerImage;
	
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
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
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getWriterImage() {
		return writerImage;
	}
	public void setWriterImage(String writerImage) {
		this.writerImage = writerImage;
	}
	
	@Override
	public String toString() {
		return "Post [postId=" + postId + ", boardId=" + boardId + ", title=" + title + ", content=" + content
				+ ", hit=" + hit + ", createDate=" + createDate + ", modifyDate=" + modifyDate + ", projectId="
				+ projectId + ", userid=" + userid + ", boardName=" + boardName + ", writerImage=" + writerImage + "]";
	}
	
}
