package kr.or.kosa.comments;

import lombok.Data;

@Data
public class Comments {
	private int commentId;
	private int postId;
	private String content;
	private String createDate;
	private String modifyDate;
	private String writerId;
	private int boardId;
}
