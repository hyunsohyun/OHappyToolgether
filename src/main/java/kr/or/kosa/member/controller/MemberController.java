package kr.or.kosa.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.kosa.member.service.MemberService;
import kr.or.kosa.member.vo.Users;

@RestController
@RequestMapping("/member")
public class MemberController {
	
	MemberService memberService;
	
	@Autowired
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping
	public ResponseEntity<List<Users>> selectAllUser() {
		System.out.println("모든 유저 목록 조회 매핑됨");
		List<Users> list = null;
		try {
			list = memberService.selectAllUser();
			return new ResponseEntity<List<Users>>(list,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("selectAllUser()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<List<Users>>(list,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@GetMapping("/users/{projectId}")
	public ResponseEntity<List<Users>> selectAllUsersByProjectId(@PathVariable("projectId") int projectId) {
		List<Users> list = null;
		try {
			list = memberService.selectAllUsersByProjectId(projectId);
			return new ResponseEntity<List<Users>>(list,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("selectAllUser()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<List<Users>>(list,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@GetMapping("{userid}")
	public ResponseEntity<Users> selectUserById(@PathVariable("userid") String userid) {
		Users user = null;
		try {
			user = memberService.selectUserById(userid);
			System.out.println("컨트롤러에서 받은 user 정보 : " + user.toString());
			
			return new ResponseEntity<Users>(user,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("selectUserById()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Users>(user,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@PostMapping("/joinForm.do")
	public ResponseEntity<Integer> insertUser(@RequestBody Users user) {
		int result = 0;
		try {
			result = memberService.insertUser(user);
			System.out.println("requestBody의 user 정보 : " + user.toString());
			
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("insertUser()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@DeleteMapping({"userid"})
	public ResponseEntity<Integer> deleteUser(@PathVariable("userid") String userid) {
		int result = 0;
		try {
			result = memberService.deleteUser(userid);
			System.out.println("삭제 요청에 따라 다음 행의 개수가 삭제됨 : "+result);			
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("deleteUser()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
	@PutMapping
	public ResponseEntity<Integer> updateUser(@RequestBody Users user) {
		int result = 0;
		try {
			result = memberService.updateUser(user);
			System.out.println("requestBody의 user 정보 : " + user.toString());
			
			return new ResponseEntity<Integer>(result,HttpStatus.OK);
		} catch (Exception e) {			
			System.out.println("insertUser()에서 터짐");
			System.out.println(e.getMessage());
			return new ResponseEntity<Integer>(result,HttpStatus.BAD_REQUEST);
		}		
	}
	
}
