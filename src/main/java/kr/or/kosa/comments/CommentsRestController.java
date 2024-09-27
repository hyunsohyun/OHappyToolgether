package kr.or.kosa.comments;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/comments")
public class CommentsRestController {

	private static final Logger logger = LoggerFactory.getLogger(CommentsRestController.class);
	private CommentsService commentsService;

	@Autowired
	public void setFileService(CommentsService commentsService) {
		this.commentsService = commentsService;
	}
	
	@GetMapping("{boardId}/{postId}")
	public ResponseEntity<List<Comments>> commentList(@PathVariable("postId") int postId,@PathVariable("boardId") int boardId) {
		List<Comments> list = null;
		try {
			Comments comment = new Comments();
			comment.setBoardId(boardId);
			comment.setPostId(postId);
			
			list = commentsService.commentList(comment);
			return new ResponseEntity<List<Comments>>(list,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println(e.getMessage());
			return new ResponseEntity<List<Comments>>(list,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@PostMapping
	public ResponseEntity<Integer> commentInsert(@RequestBody Comments comments, HttpSession session) {
		System.out.println(comments.toString());
		int result = 0;

		try {
			result = commentsService.commentInsert(comments);
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@DeleteMapping
	public ResponseEntity<Integer> commentDelete(@RequestBody Comments comments) {
		int result = 0;
		try {
			result = commentsService.commentDelete(comments);
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@PutMapping
	public ResponseEntity<Integer> commentUpdate(@RequestBody Comments comments) {
		int result = 0;
		try {
			result = commentsService.commentUpdate(comments);
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
}
