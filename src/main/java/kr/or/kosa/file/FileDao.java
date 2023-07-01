package kr.or.kosa.file;

import java.sql.SQLException;
import java.util.List;

public interface FileDao {
	
	public List<File> fileList(int postId) throws ClassNotFoundException, SQLException;
	public File fileDetail(String fileId) throws ClassNotFoundException, SQLException;
	public int fileInsert(File file) throws ClassNotFoundException, SQLException;
	public int fileUpdate(File file) throws ClassNotFoundException, SQLException;
	public int fileDelete(File file) throws ClassNotFoundException, SQLException;
	
}
