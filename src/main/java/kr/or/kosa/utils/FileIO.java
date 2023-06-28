package kr.or.kosa.utils;

import java.io.File;
import java.util.UUID;

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
	
}
