package kr.or.kosa.file;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.kosa.post.Post;

@Service
public class FileService{

	private SqlSession sqlsession;

	@Autowired
	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	//파일정보 테이블 등록
	//파일 리스트
	public List<FileInfo> filelist(FileInfo file) throws Exception{
		List<FileInfo> fileList = null;
		System.out.println("sqlsession" + sqlsession);

		try {
			FileDao filedao = sqlsession.getMapper(FileDao.class);
			fileList = filedao.fileList(file);
		} catch(Exception e) {
			e.getStackTrace();
			System.out.println(e.getMessage());
		}
		return fileList;
	}
	
	
	//파일 상세
	public FileInfo fileDetail(String FileId){
		FileInfo File = null;
		try {
			//파일정보 테이블 등록
			FileDao filedao = sqlsession.getMapper(FileDao.class);
			File = filedao.fileDetail(FileId);
		}catch (Exception e) {
			System.out.println("맵퍼 안가져옴");
			System.out.println(e.getMessage());
		}

		return File;
	}

	//파일쓰기
	public int fileInsert(FileInfo file){
		int result = 0;
		try {
			//파일Info 테이블 insert
			FileDao filedao = sqlsession.getMapper(FileDao.class);
			result = filedao.fileInsert(file);
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return result;
	}
	
	//파일수정
	public FileInfo FileUpdate(FileInfo File){
		try {
			FileDao filedao = sqlsession.getMapper(FileDao.class);
			int n = filedao.fileUpdate(File);
			if(n>0) {
				System.out.println("파일수정 성공");
			}else {
				System.out.println("파일수정 실패 ");
			}
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return File;
	}
	
	//파일삭제
	public FileInfo FileDelete(FileInfo File){
		try {
			FileDao filedao = sqlsession.getMapper(FileDao.class);
			int n = filedao.fileDelete(File);
			if(n>0) {
				System.out.println("파일삭제 성공");
			}else {
				System.out.println("파일삭제 실패 ");
			}
		}catch (Exception e) {
			System.out.println("오류발생");
			System.out.println(e.getMessage());
		}

		return File;
	}
}
