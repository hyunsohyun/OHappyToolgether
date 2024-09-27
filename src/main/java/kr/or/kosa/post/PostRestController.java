package kr.or.kosa.post;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	//조회수 update
	@PutMapping
	public void update(@RequestBody Post post) {
	    try {
	        postService.postHitUpdate(post);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
	
	//글 등록
	@PostMapping("/insert")
	public ResponseEntity<Integer> postInsert(@RequestBody Post post, HttpSession session) {
		try {
			post.setUserid((String)session.getAttribute("userid"));
			System.out.println(post.toString());
			
			int postId = postService.postInsert(post);
			return new ResponseEntity<Integer>(postId,HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
		}
	}
	
	//프로젝트의 최신글 5개 조회
	@GetMapping("/recentPostList")
	public ResponseEntity<List<Post>> recentPostList(@RequestParam("projectId") int projectId){
		System.out.println("@GetMapping(\"/recentPostList\") 매핑");
		List<Post> list = null;		
		try {
			list = postService.recentPostList(projectId);
			return new ResponseEntity<List<Post>>(list,HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("recentPostList에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<List<Post>>(list,HttpStatus.BAD_REQUEST);
		}
		
	}
	
	//글수정
	@PostMapping(value="/update")
	public ResponseEntity<Integer> postUpdate(@RequestBody Post post, Model model) {
		try {
			int result = postService.postUpdate(post);
			if(result>0) {
				return new ResponseEntity<Integer>(post.getPostId(),HttpStatus.OK);
			}else {
				return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
			}
		}catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
		}
	}

	//글삭제
	@DeleteMapping(value="/delete")
	public ResponseEntity<Integer> postDelete(@RequestBody Post post, Model model) {
		try {
			int result = postService.postDelete(post);
			if(result>0) {
				return new ResponseEntity<Integer>(post.getPostId(),HttpStatus.OK);
			}else {
				return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
		}
	}
}
