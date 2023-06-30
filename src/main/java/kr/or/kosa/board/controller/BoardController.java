package kr.or.kosa.board.controller;

import java.util.ArrayList;
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

import kr.or.kosa.board.service.BoardService;
import kr.or.kosa.board.vo.Board;

@RestController
@RequestMapping("/board")
public class BoardController {

	private BoardService boardService;

	@Autowired
	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	// 게시판 생성
	@PostMapping
	public ResponseEntity<String> insertBoard(@RequestBody Board board) {
		try {
			System.out.println("insert 실행");
			System.out.println(board.toString());
			boardService.insertBoard(board);
			return new ResponseEntity<String>("insert success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("insert fail", HttpStatus.BAD_REQUEST);
		}
	}

	// 게시판 전체 조회
	@GetMapping("/{projectId}")
	public ResponseEntity<List<Board>> boardList(@PathVariable("projectId") int projectId) {
		List<Board> list = new ArrayList<Board>();
		try {
			System.out.println("정상실행");
			list = boardService.selectBoardList(projectId);
			return new ResponseEntity<List<Board>>(list, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<List<Board>>(list, HttpStatus.BAD_REQUEST);
		}

	}

	// 게시판 수정
	@PutMapping
	public ResponseEntity<String> updateBoard(@RequestBody Board board) {
		try {
			System.out.println("update 실행");
			System.out.println(board.toString());
			boardService.updateBoard(board);
			return new ResponseEntity<String>("update success", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("update fail", HttpStatus.BAD_REQUEST);
		}
	}

	@DeleteMapping("/{boardId}")
	public ResponseEntity<String> deleteBoard(@PathVariable("boardId") int boardId) {

		try {
			System.out.println("delete 실행");
			boardService.deleteBoard(boardId);
			return new ResponseEntity<String>("delete success", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<String>("delete fail", HttpStatus.BAD_REQUEST);
		}

	}

}
