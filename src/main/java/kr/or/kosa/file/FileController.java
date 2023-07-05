package kr.or.kosa.file;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.or.kosa.post.Post;
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
	@GetMapping("/fileList.do")
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
	
	@PostMapping("projectimg/insert")
	public ResponseEntity<Integer> projectimgInsert(@RequestParam("uploadFile") MultipartFile file, 													
													@RequestParam("projectId") String projectId, 
													HttpSession session) {
	    int result = 0;
	    try {
    		// FileIO에 요청해서 업로드하기
    		String filepath = FileIO.uploadProjectimg(file, projectId, session);
    		if(!filepath.equals("")) result = 1;
	        return new ResponseEntity<Integer>(result, HttpStatus.OK);

	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	        return new ResponseEntity<Integer>(result, HttpStatus.BAD_REQUEST);
	    }	
	}
	
	//파일업로드
	@PostMapping("post/upload")
	public ResponseEntity<Integer> postInsert(@RequestParam("uploadFiles") List<MultipartFile> files, String postId, int boardId, HttpSession session) {
	   
	    int result = 0;
	    try {
	    	for(MultipartFile file : files) {

	    		// FileIO에 요청해서 업로드하기
	    		String filepath = FileIO.uploadFiles(file, "post" ,session);
	    		
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
	public ResponseEntity<Integer> postInsert(@RequestParam("uploadFile") MultipartFile file, @PathVariable("key") String key, HttpSession session) {
	   
	    int result = 0;
	    try {
    		// FileIO에 요청해서 업로드하기
    		String filepath = FileIO.uploadFiles(file, key, session);
    		if(!filepath.equals("")) result = 1;
	        return new ResponseEntity<Integer>(result, HttpStatus.OK);

	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	        return new ResponseEntity<Integer>(result, HttpStatus.BAD_REQUEST);
	    }	
	}

	
	//파일 다운로드
	@GetMapping("/download/{postId}/{fileId}")
	public ResponseEntity<Integer> fileDown(@PathVariable("postId") int postId,@PathVariable("fileId") int fileId, HttpServletRequest request, HttpServletResponse response) throws Exception{
		int result = 0;
		try {
			FileInfo fileInfo = new FileInfo();
			fileInfo.setFileId(fileId);
			fileInfo.setPostId(postId);
			fileInfo = fileService.fileDetail(fileInfo);
			result = FileIO.fileDown(fileInfo, request, response);
			return new ResponseEntity<Integer>(result, HttpStatus.OK);
			
		} catch (Exception e) {
	        System.out.println(e.getMessage());
	        return new ResponseEntity<Integer>(result, HttpStatus.BAD_REQUEST);
	    }	
	}
	
	//DB파일 삭제
	@DeleteMapping(value="/delete")
	public ResponseEntity<Integer> postDelete(@RequestBody FileInfo fileInfo, Model model) {
		try {
			int result = fileService.fileDelete(fileInfo);
			
			if(result>0) {
				return new ResponseEntity<Integer>(result,HttpStatus.OK);
			}else {
				return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
			}
		}catch(Exception e) {
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(-1,HttpStatus.BAD_REQUEST);
		}
	}
	
}
