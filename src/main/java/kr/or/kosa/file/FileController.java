package kr.or.kosa.file;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FileController {

	private static final Logger logger = LoggerFactory.getLogger(FileController.class);

	private FileService FileService;

	@Autowired
	public void setFileService(FileService FileService) {
		this.FileService = FileService;
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
	
	
	
}
