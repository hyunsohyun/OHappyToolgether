package kr.or.kosa.file;

public class FileInfo {
	private int fileId; 
	private int postId; 
	private String realFileName; 
	private String hashFileName; 
	private String filePath; 
	private int boardId;
	private long fileSize;
	private String userid;
	
	public int getFileId() {
		return fileId;
	}
	public void setFileId(int fileId) {
		this.fileId = fileId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getRealFileName() {
		return realFileName;
	}
	public void setRealFileName(String realFileName) {
		this.realFileName = realFileName;
	}
	public String getHashFileName() {
		return hashFileName;
	}
	public void setHashFileName(String hashFileName) {
		this.hashFileName = hashFileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	
	
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	@Override
	public String toString() {
		return "File [fileId=" + fileId + ", postId=" + postId + ", realFileName=" + realFileName + ", hashFileName="
				+ hashFileName + ", filePath=" + filePath + ", boardId=" + boardId + ", fileSize=" + fileSize + "]";
	} 
	
}
