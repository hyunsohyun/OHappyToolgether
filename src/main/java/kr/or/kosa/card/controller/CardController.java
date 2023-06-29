package kr.or.kosa.card.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import kr.or.kosa.card.vo.Card;
import kr.or.kosa.card.service.CardService;

@RestController
@RequestMapping("/card")
public class CardController {
	
	private CardService cardservice;

	@Autowired
	public void setCardService(CardService cardservice) {
		this.cardservice = cardservice;
	}
	
	// 칸반보드 select 컨트롤러
	@GetMapping("{projectId}/{kanbanboardId}")
	public ResponseEntity<List<Card>> selectByBoardSq(@PathVariable("projectId") int projectId, @PathVariable("kanbanboardId") int kanbanboardId){
		List<Card> list = new ArrayList<Card>();
		try {
			System.out.println("칸반보드 select 컨트롤러 실행");
			
			list = cardservice.selectByBoardSq(projectId, kanbanboardId);
			return new ResponseEntity<List<Card>>(list,HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<List<Card>>(list, HttpStatus.BAD_REQUEST);
		}
	}
	
	// 칸반보드 insert 컨트롤러
	@PostMapping
	public ResponseEntity<Map<String, String>> insert(@RequestBody Card card) {
		Map<String, String> response = new HashMap<String, String>();
		try {
			System.out.println("칸반보드 insert 컨트롤러 실행");
			cardservice.insertCard(card);
			response.put("message", "insert success");
			return new ResponseEntity<Map<String, String>>(response, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String, String>>(response, HttpStatus.BAD_REQUEST); 
		}
	}
	
	// 칸반보드 update 컨트롤러
	@PutMapping("{cardId}")
	public ResponseEntity<Map<String, String>> update(@RequestBody Card card, @PathVariable("cardId") int cardId) {
		Map<String, String> response = new HashMap<String, String>();
		card.setCardId(cardId);
		try {
			System.out.println("칸반보드 update 컨트롤러 실행");
			System.out.println(card.toString());
			
			cardservice.updateCard(card);
			
			System.out.println("업데이트 실행 완료");
			response.put("message", "update success");
			return new ResponseEntity<Map<String, String>>(response, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String, String>>(response, HttpStatus.BAD_REQUEST); 
		}
	}
	
	// 칸반보드 delete 컨트롤러
	@DeleteMapping("{cardId}")
	public ResponseEntity<Map<String, String>> delete(@PathVariable("cardId") int cardId) {
		Map<String, String> response = new HashMap<String, String>();
		try {
			System.out.println("칸반보드 delete 컨트롤러 실행");
			cardservice.deleteCard(cardId);
			response.put("message", "delete success");
			return new ResponseEntity<Map<String, String>>(response, HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Map<String, String>>(response, HttpStatus.BAD_REQUEST);
		}
	}
}
