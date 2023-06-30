package kr.or.kosa.post;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/post")
public class PostRestController {
	
	private PostService postService;

	@Autowired
	public void setPostService(PostService postService) {
		this.postService = postService;
	}
	
	// 조회수 update
	@PostMapping("/updateHit")
	public void update(@RequestParam int postId) {
		try {
			postService.postHitUpdate(postId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
