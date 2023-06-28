package kr.or.kosa.member.vo;

import lombok.Data;

@Data
public class Users {
	private String userid;
	private String password;
	private String name;
	private int enabled;
	private String email;
	private String image;
}
