package kr.or.kosa.post;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PostController {

	private static final Logger logger = LoggerFactory.getLogger(PostController.class);

	private PostService postService;

	@Autowired
	public void setPostService(PostService postService) {
		this.postService = postService;
	}

	/* 게시판 템플릿 페이지*/
	@RequestMapping("/postList.do")
	public String postList(Model model) throws Exception{
		List<Post> postlist = postService.postlist();
		model.addAttribute("list", postlist);
		return "post/postList";
	}
	
	/* 게시판 템플릿 페이지*/
	@RequestMapping("/postDetail.do")
	public String postDetail(String postId, Model model) throws Exception{
		Post post = postService.postDetail(postId);
		model.addAttribute("post", post);
		return "post/postDetail";
	}

}
