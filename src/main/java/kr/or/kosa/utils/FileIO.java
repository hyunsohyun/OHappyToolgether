package kr.or.kosa.utils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

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
	
	
}
