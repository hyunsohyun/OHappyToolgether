package kr.or.kosa.post;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	@RequestMapping("/postList/{projectId}/{boardId}")
	public String postList(@PathVariable("projectId") String projectId,@PathVariable("boardId") String boardId, Model model) throws Exception{
		
		model.addAttribute("boardId", boardId);
		model.addAttribute("projectId", projectId);

		//글 리스트
		List<Post> postlist = postService.postlist(boardId);
		model.addAttribute("list", postlist);
		
		//게시판 이름
		model.addAttribute("boardName", "공지사항게시판");
		
		return "post/postList";
	}
	
	//글상세 페이지
	@RequestMapping(value="/postDetail")
	public String postDetail(@ModelAttribute Post postParam, Model model) throws Exception{
		
		//글 info
		Post post = postService.postDetail(postParam);
		model.addAttribute("post", post);

		//파일리스트
		FileInfo file = new FileInfo();
		file.setBoardId(postParam.getBoardId());
		file.setPostId(postParam.getPostId());
		
		List<FileInfo> fileList = fileService.filelist(file);
		if(fileList != null) {
			model.addAttribute("fileList", fileList);
		}
		
		//댓글리스트
		Comments comment = new Comments();
		comment.setBoardId(postParam.getBoardId());
		comment.setPostId(postParam.getPostId());

		List<Comments> commentList = commentsService.commentList(comment);
		if(commentList != null) {
			model.addAttribute("commentList", commentList);
		}
		
		return "post/postDetail";
	}
	
	//글등록 페이지
	@GetMapping(value="/postInsert/{projectId}/{boardId}")
	public String postInsert(@PathVariable("boardId") int boardId, @PathVariable("projectId") int projectId, Model model) {
		model.addAttribute("projectId", projectId);
		model.addAttribute("boardId", boardId);
		return "post/postInsert";
	}
	
	
	//글수정 페이지
	@GetMapping(value="/postUpdate.do")
	public String postUpdate(@ModelAttribute int boardId) {
		return "post/postUpdate";
	}
	
	//글수정
	@PostMapping(value="/postUpdate")
	public String postUpdate(@ModelAttribute Post post, Model model) {
		try {
			postService.postUpdate(post);
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return "redirect:postDetail/" + post.getProjectId()+ "/" + post.getBoardId();
	}
	
	//글삭제
	@GetMapping(value="/postDelete")
	public String postDelete(@ModelAttribute Post post, Model model) {
		try {
			postService.postDelete(post);
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return "redirect:postList/" + post.getProjectId()+ "/" + post.getBoardId();
	}
	
	
}
