package kr.or.kosa.post;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/post")
public class PostRestController {
	
	private static final Logger logger = LoggerFactory.getLogger(PostRestController.class);
	private PostService postService;

	@Autowired
	public void setPostService(PostService postService) {
		this.postService = postService;
	}
	
	// 조회수 update
	@PutMapping
	public void update(@RequestBody Post post) {
	    try {
	        postService.postHitUpdate(post.getPostId());
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	//글 등록
	@PostMapping("/insert")
	public ResponseEntity<Integer> postInsert(@RequestBody Post post, HttpSession session) {
		try {
			//userid setting
			//post.setUserid((String)session.getAttribute("userid"));
			post.setUserid("hsh");
			System.out.println(post.toString());
			
			int postId = postService.postInsert(post);
			return new ResponseEntity<Integer>(postId,HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
		}
	}

}
