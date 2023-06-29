package kr.or.kosa.comments;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CommentsController {

	private static final Logger logger = LoggerFactory.getLogger(CommentsController.class);

	private CommentsService commentsService;

	@Autowired
	public void setFileService(CommentsService commentsService) {
		this.commentsService = commentsService;
	}
	
	
}
