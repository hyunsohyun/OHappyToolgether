package kr.or.kosa.post;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
}
