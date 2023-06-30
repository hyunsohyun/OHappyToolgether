package kr.or.kosa.file;

public class File {
	private int fileId; 
	private int postId; 
	private String realFileName; 
	private String hashFileName; 
	private String FilePath; 
	private int boardId;
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
		return FilePath;
	}
	public void setFilePath(String filePath) {
		FilePath = filePath;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	} 
	
}
