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
import javax.servlet.http.HttpSession;

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
		if (!dir.exists()) {
			dir.mkdir();
		}
		return dir;
	}

	// 파일업로드
	public static String uploadFiles(MultipartFile file, String key, HttpSession session) throws Exception {

		String result = "";
		String filePath = "";
		String pathCate = "";

		// Map<String, String> articleMap = new HashMap<String, String>();

		System.out.println("FileUtil.uploadFiles START request >>" + file);

		if ("post".equals(key)) {
			pathCate = "post";

			// C드라이브/사용자/내문서/파일/
			filePath = System.getProperty("user.home") + "\\Documents\\" + pathCate
					+ System.getProperty("file.separator");
			System.out.println("저장 파일경로 : " + filePath);

			File currentDirPath = new File(filePath);
			if (!currentDirPath.isDirectory())
				currentDirPath.mkdirs();

			File uploadFile = new File(currentDirPath + "/" + FileIO.getUuid());
			file.transferTo(uploadFile);
			result = uploadFile.getAbsolutePath();

		} else {
			String fileName = "";
			if ("projectimg".equals(key)) {
				pathCate = "projectimg";
				fileName = String.valueOf(session.getAttribute("projectId")) + file.getOriginalFilename();
				System.out.println("fileName + " + fileName);
			}
			if ("users".equals(key)) {
				pathCate = "users";
				fileName = (String)session.getAttribute("userid") + file.getOriginalFilename();
			}
			String rootPath = session.getServletContext().getRealPath("/");
			String uploadPath = rootPath + "resource" + File.separator + pathCate + File.separator;

			File uploadFile = new File(uploadPath + fileName);
			if (!uploadFile.isDirectory())
				uploadFile.mkdirs();
			file.transferTo(uploadFile);
			result = uploadFile.getAbsolutePath();

			System.out.println("저장될 파일 경로 : " + result);
		}
		// 저장된 파일경로
		return result;
	}

	public static String uploadProjectimg(MultipartFile file, String projectId, HttpSession session) throws Exception {

		String result = "";
		String filePath = "";

		System.out.println("FileUtil.uploadFiles START request >>" + file);

		String pathCate = "projectimg";
		String fileName = projectId + file.getOriginalFilename();
		System.out.println("fileName : " + fileName);

		String rootPath = session.getServletContext().getRealPath("/");
		String uploadPath = rootPath + "resource" + File.separator + pathCate + File.separator;
		System.out.println("uploadPath : " + uploadPath);

		File uploadFile = new File(uploadPath + fileName);
		if (!uploadFile.isDirectory())
			uploadFile.mkdirs();

		file.transferTo(uploadFile);
		result = uploadFile.getAbsolutePath();

		System.out.println("저장될 파일 경로 : " + result);

		// 저장된 파일경로
		return fileName;
	}

	public static int fileDown(FileInfo fileInfo, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
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
