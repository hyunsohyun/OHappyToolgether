package kr.or.kosa.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.util.MimeType;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.kosa.file.FileInfo;

public class FileIO {	
	
	public static String getUuid() {		
		return UUID.randomUUID().toString();
	}
	
	public static File getDir(String path) {
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdir();
		}
		return dir;
	}

	//파일업로드
	public static String uploadFiles(MultipartFile file, String key) throws Exception {
		
        String result = "";
        String filePath = "";
        String pathCate = "";
        Map<String, String> articleMap = new HashMap<String, String>();

        System.out.println("FileUtil.uploadFiles START request >>" + file);

        if("projectImg".equals(key)) pathCate = "project_img";
        if("members".equals(key)) pathCate = "members";
        else pathCate = "post";

        filePath = System.getProperty("user.home") + "\\Documents\\" + pathCate + System.getProperty("file.separator");
        //저장되는 경로는 C드라이브/사용자/내문서/파일/
        System.out.println("저장 파일경로 : " + filePath);
        
        SimpleDateFormat dateFormat = new SimpleDateFormat ("yyyyMMddHHmmss"); 
        Date time = new Date(); 
        String timestamp = dateFormat.format(time);

        File currentDirPath = new File(filePath);
        if (!currentDirPath.isDirectory()) currentDirPath.mkdirs();    

        String fieldNameName = file.getName();
        String fileName = file.getOriginalFilename();
        
        //File uploadFile = new File(currentDirPath + "/" + timestamp + "_" + fileName);
        File uploadFile = new File(currentDirPath + "/" + FileIO.getUuid());
        
        articleMap.put(fieldNameName, fileName);
        file.transferTo(uploadFile);

        result = uploadFile.getAbsolutePath();

        return result;
    }
	
	
	public static int fileDown(FileInfo fileInfo, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    int result = 0;
	    String filepath = fileInfo.getFilePath();
	    String filename = fileInfo.getRealFileName();
	    String path = filepath;
	    File file = new File(path);

	    String userAgent = request.getHeader("User-Agent");
	    boolean ie = userAgent != null && userAgent.indexOf("MSIE") > -1;
	    String encodedFilename;

	    if (ie) {
	        encodedFilename = URLEncoder.encode(filename, "UTF-8");
	        encodedFilename = encodedFilename.replace("+", "%20"); // 공백 문자 처리
	    } else {
	        encodedFilename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
	    }

	    response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFilename + "\"");
	    response.setHeader("Content-Transfer-Encoding", "binary");

	    // 파일 다운로드
	    OutputStream out = response.getOutputStream();
	    FileInputStream fis = null;

	    try {
	        fis = new FileInputStream(file);
	        result = FileCopyUtils.copy(fis, out);
	    } catch (Exception e) {
	        System.out.println(e.getMessage());
	    } finally {
	        if (fis != null) {
	            try {
	                fis.close();
	            } catch (Exception e2) {
	                System.out.println(e2.getMessage());
	            }
	        }
	    }

	    return result;
	}
	
}
