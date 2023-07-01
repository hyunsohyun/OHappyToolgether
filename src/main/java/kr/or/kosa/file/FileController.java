package kr.or.kosa.file;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.kosa.post.Post;

@RestController
@RequestMapping("/file")
public class FileController {

	private static final Logger logger = LoggerFactory.getLogger(FileController.class);

	private FileService fileService;

	@Autowired
	public void setFileService(FileService FileService) {
		this.fileService = fileService;
	}

//	//파일리스트
//	@RequestMapping("/FileList.do")
//	public String FileList(Model model) throws Exception{
//		List<File> Filelist = FileService.Filelist();
//		model.addAttribute("list", Filelist);
//		return "File/FileList";
//	}
//	
//	//파일상세 페이지
//	@RequestMapping("/FileDetail.do")
//	public String FileDetail(String FileId, Model model) throws Exception{
//		File File = FileService.FileDetail(FileId);
//		model.addAttribute("File", File);
//		return "File/FileDetail";
//	}
//	
//	//파일등록 페이지
//	@GetMapping(value="/FileInsert.do")
//	public String FileInsert() {
//		return "File/FileInsert";
//	}
//	
	
	@PostMapping("/insert")
	public ResponseEntity<Integer> postInsert(@RequestBody Map<String,String> param) {
		try {
			param.get("files");
			//int postId = fileService.fileInsert(file);
			return new ResponseEntity<Integer>(postId,HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
		}
	}
	
	
}
