package kr.or.kosa.comments;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.kosa.member.vo.Users;

@RestController
@RequestMapping("/comments")
public class CommentsRestController {

	private static final Logger logger = LoggerFactory.getLogger(CommentsRestController.class);
	private CommentsService commentsService;

	@Autowired
	public void setFileService(CommentsService commentsService) {
		this.commentsService = commentsService;
	}
	
	@GetMapping("{postId}")
	public ResponseEntity<List<Comments>> commentList(@PathVariable("postId") int postId) {
		List<Comments> list = null;
		try {
			list = commentsService.commentList(postId);
			return new ResponseEntity<List<Comments>>(list,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println(e.getMessage());
			return new ResponseEntity<List<Comments>>(list,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@PostMapping
	public ResponseEntity<Integer> commentInsert(@RequestBody Comments comments) {
		System.out.println(comments.toString());
		int result = 0;

		try {
			//임시 데이터
			comments.setBoardId(0);
			comments.setWriterId("hsh");
			//////
			
			result = commentsService.commentInsert(comments);
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	
}
