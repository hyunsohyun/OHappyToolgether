package kr.or.kosa.post;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.kosa.comments.Comments;
import kr.or.kosa.comments.CommentsService;
import kr.or.kosa.file.FileInfo;
import kr.or.kosa.file.FileService;

@Controller
public class PostController {

	private static final Logger logger = LoggerFactory.getLogger(PostController.class);

	private PostService postService;
	private FileService fileService;
	private CommentsService commentsService;
	
	@Autowired
	public void setPostService(PostService postService) {
		this.postService = postService;
	}
	
	@Autowired
	public void setCommentsService(CommentsService commentsService) {
		this.commentsService = commentsService;
	}
	
	@Autowired
	public void setCommentsService(FileService fileService) {
		this.fileService = fileService;
	}


	//글리스트
	@RequestMapping("/postList/{boardId}")
	public String postList(@PathVariable("boardId") String boardId, Model model) throws Exception{
		
		model.addAttribute("boardId", boardId);

		//글 리스트
		List<Post> postlist = postService.postlist(boardId);
		model.addAttribute("list", postlist);
		
		//게시판 이름
		model.addAttribute("boardName", "공지사항게시판");
		
		return "post/postList";
	}
	
	//글상세 페이지
	@RequestMapping(value="/postDetail/{boardId}/{postId}")
	public String postDetail(@PathVariable("boardId") int boardId,@PathVariable("postId") int postId, Model model,HttpSession session) throws Exception{
		
		//글 info
		Post post = new Post();
		post.setProjectId((int)session.getAttribute("projectId"));
		post.setBoardId(boardId);
		post.setPostId(postId);
		
		post = postService.postDetail(post);
		model.addAttribute("post", post);

		//파일리스트
		FileInfo file = new FileInfo();
		file.setBoardId(post.getBoardId());
		file.setPostId(post.getPostId());
		
		List<FileInfo> fileList = fileService.filelist(file);
		if(fileList != null) {
			model.addAttribute("fileList", fileList);
		}
		
		//댓글리스트
		Comments comment = new Comments();
		comment.setBoardId(post.getBoardId());
		comment.setPostId(post.getPostId());

		List<Comments> commentList = commentsService.commentList(comment);
		if(commentList != null) {
			model.addAttribute("commentList", commentList);
		}
		
		return "post/postDetail";
	}
	
	//글등록 페이지
	@GetMapping(value="/postInsert/{boardId}")
	public String postInsert(@PathVariable("boardId") int boardId, Model model) {
		
		model.addAttribute("boardId", boardId);
		return "post/postInsert";
	}
	
	//글수정 페이지
	@GetMapping(value="/postUpdate")
	public String postUpdate(@RequestParam("boardId") int boardId, @RequestParam("postId") int postId, Model model) {
		
		//상세정보 담기
		Post post = new Post();
	    post.setBoardId(boardId);
	    post.setPostId(postId);
	    post = postService.postDetail(post);
	    
	    model.addAttribute("post", post);

	    return "post/postUpdate";
	}
	
}
