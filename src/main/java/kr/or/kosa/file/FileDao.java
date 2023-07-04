package kr.or.kosa.file;

import java.sql.SQLException;
import java.util.List;

public interface FileDao {
	
	public List<FileInfo> fileList(FileInfo file) throws ClassNotFoundException, SQLException;
	public FileInfo fileDetail(FileInfo fileInfo) throws ClassNotFoundException, SQLException;
	public int fileInsert(FileInfo file) throws ClassNotFoundException, SQLException;
	public int fileUpdate(FileInfo file) throws ClassNotFoundException, SQLException;
	public int fileDelete(FileInfo file) throws ClassNotFoundException, SQLException;
	
}
