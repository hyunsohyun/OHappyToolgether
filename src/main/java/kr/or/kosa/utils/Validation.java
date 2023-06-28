package kr.or.kosa.utils;

public class Validation {
	
	public boolean isValidId(String id) {
        return id.matches("^[a-zA-Z]{1}[a-zA-Z0-9_]{4,11}$");
    }

    public boolean isValidPassword(String pw) {
        return pw.matches("^(?=.*[a-zA-Z])(?=.*\\d)(?=.*\\W).{8,20}$");
    }

    public boolean isValidName(String name) {
        return name.matches("^[가-힣]*$");
    }
    
    public boolean isVaildEmail(String email) {
    	return email.matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");
    }

}
