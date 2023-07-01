package kr.or.kosa.post;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.kosa.comments.Comments;
import kr.or.kosa.comments.CommentsService;
import kr.or.kosa.file.File;
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
	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}
	@Autowired
	public void setCommentsService(CommentsService commentsService) {
		this.commentsService = commentsService;
	}

	//글리스트
	@RequestMapping("/postList.do")
	public String postList(String boardId, Model model) throws Exception{
		
		//글 리스트
		List<Post> postlist = postService.postlist(boardId);
		model.addAttribute("list", postlist);
		model.addAttribute("boardId", boardId);
		
		//게시판 이름
		//의진오빠가 했겠지
		model.addAttribute("boardName", "공지사항게시판");
		
		return "post/postList";
	}
	
	//글상세 페이지
	@RequestMapping("/postDetail.do")
	public String postDetail(@ModelAttribute Post postParam, Model model) throws Exception{
		
		int postId = postParam.getPostId();
		
		//글 info
		Post post = postService.postDetail(postId);
		model.addAttribute("post", post);

		//파일리스트
		List<File> fileList = fileService.filelist(postId);
		if(fileList != null) {
			model.addAttribute("fileList", fileList);
		}
		
		//댓글리스트
		List<Comments> commentList = commentsService.commentList(postId);
		if(commentList != null) {
			model.addAttribute("commentList", commentList);
		}
		
		return "post/postDetail";
	}
	
	//글등록 페이지
	@GetMapping(value="/postInsert.do")
	public String postInsert(@ModelAttribute("boardId") int boardId) {
		
		return "post/postInsert";
	}

	
	//글수정 페이지
	@GetMapping(value="/postUpdate.do")
	public String postUpdate(@ModelAttribute int boardId) {
		return "post/postUpdate";
	}
	
	//글수정
	@PostMapping(value="/postUpdate.do")
	public String postUpdate(@ModelAttribute Post post, Model model) {
		postService.postUpdate(post);
		return "post/postDetail";
	}
	
	//글삭제
	@GetMapping(value="/postDelete.do")
	public String postDelete(@ModelAttribute Post post, Model model) {
		postService.postDelete(post.getPostId());
		return "redirect:postList.do?boardId=" + post.getBoardId();
	}
	
}
