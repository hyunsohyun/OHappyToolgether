package kr.or.kosa.file;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.or.kosa.utils.FileIO;

@RestController
@RequestMapping("/file")
public class FileController {

	private static final Logger logger = LoggerFactory.getLogger(FileController.class);

	private FileService fileService;

	@Autowired
	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	//파일리스트
	@GetMapping("/FileList.do")
	public ResponseEntity<List<FileInfo>> FileList(@RequestParam FileInfo file, Model model) throws Exception{
		List<FileInfo> Filelist = null;
		try {
			Filelist = fileService.filelist(file);
			return new ResponseEntity<List<FileInfo>>(Filelist, HttpStatus.OK);
		}catch (Exception e) {
	        System.out.println(e.getMessage());
	        return new ResponseEntity<List<FileInfo>>(Filelist, HttpStatus.BAD_REQUEST);
	    }
	}
	
	
	@PostMapping("post/upload")
	public ResponseEntity<Integer> postInsert(@RequestParam("uploadFiles") List<MultipartFile> files, String postId, int boardId, HttpSession session) {
	   
	    int result = 0;
	    try {
	    	for(MultipartFile file : files) {

	    		// FileIO에 요청해서 업로드하기
	    		String filepath = FileIO.uploadFiles(file, "post");
	    		
	    		// FileService에 요청해서 DB에 insert 하기
	    		FileInfo fileInfo = new FileInfo();
	    		fileInfo.setPostId(Integer.parseInt(postId));
	    		fileInfo.setRealFileName(file.getOriginalFilename());
	    		fileInfo.setHashFileName(filepath);
	    		fileInfo.setUserid((String)session.getAttribute("userid"));
	    		fileInfo.setBoardId(boardId);
                fileInfo.setFilePath(filepath);
                fileInfo.setFileSize(file.getSize());
    			
	    		result += fileService.fileInsert(fileInfo);
	    	}
	    	//파일갯수
	        return new ResponseEntity<Integer>(result, HttpStatus.OK);
	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	        return new ResponseEntity<Integer>(result, HttpStatus.BAD_REQUEST);
	    }	
	}
	
	@PostMapping("{key}/upload")
	public ResponseEntity<Integer> postInsert(@RequestParam("uploadFile") MultipartFile file, @PathVariable("key") String key) {
	   
	    int result = 0;
	    try {

    		// FileIO에 요청해서 업로드하기
    		String filepath = FileIO.uploadFiles(file, key);
    		if(!filepath.equals("")) result = 1;
    		// FileService에 요청해서 DB에 insert 하기
//    		FileInfo fileInfo = new FileInfo();
//    		fileInfo.setPostId(Integer.parseInt(postId));
//    		fileInfo.setRealFileName(file.getOriginalFilename());
//    		fileInfo.setHashFileName(FileIO.getUuid());
//    		
//    		//fileInfo.setUserid((String)session.getAttribute("userid"));
//    		fileInfo.setUserid("hsh");
//    		
//    		fileInfo.setBoardId(boardId);
//    		fileInfo.setFilePath(filepath);
//    		fileInfo.setFileSize(file.getSize());
//    		System.out.println(fileInfo.toString());
//			
//    		result = fileService.fileInsert(fileInfo);
	    	
	        return new ResponseEntity<Integer>(result, HttpStatus.OK);

	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	        return new ResponseEntity<Integer>(result, HttpStatus.BAD_REQUEST);
	    }	
	}
	
	
}
