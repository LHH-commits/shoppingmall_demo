package com.shoppingmall.demo.controller;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shoppingmall.demo.service.UserService;
import com.shoppingmall.demo.domain.Users;
import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.Board;
import com.shoppingmall.demo.domain.Category;
import com.shoppingmall.demo.service.BoardService;
import com.shoppingmall.demo.service.CategoryService;

@Controller
public class BoardController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	BoardService boardservice;

	@Autowired
	UserService userservice;
	
	@Autowired
	CategoryService categoryservice;

	@GetMapping("/admin/board")
	public String board(Model model) {
		return "/adminBoard";
	}

	// 이거 일단 보류 현재는 쓰이지 않는다 후에 ajax 사용할때 다시 수정할 수도?
	@GetMapping("/boardList")
	public String boardList(
		@RequestParam(value = "page", defaultValue = "1") int page,
		@RequestParam(value = "type", defaultValue = "NOTICE") String type,
		Model model
	) {
		int count = boardservice.countBoardByType(type);
		
		Pagination pagination = new Pagination();
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.build();

		Map<String, Object> params = new HashMap<>();
		params.put("type", type);
		params.put("pagination", pagination);
		
		List<Board> bList = boardservice.selectBoardList(params);
		
		model.addAttribute("bList", bList);
		model.addAttribute("pagination", pagination);
		model.addAttribute("type", type);

		return "/boardList";
	}

	//관리자화면의 게시물 상세
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/boardDetail")
	public String adminBoardDetail(
		@RequestParam("bId") int bId,
		@RequestParam(value = "type", defaultValue = "NOTICE") String type,
		Model model
	) {
		Board board = boardservice.selectBoardBidNoCount(bId);
		model.addAttribute("board", board);
		model.addAttribute("type", type);
		
		return "/admin/" + (type.equals("NOTICE") ? "notice_detail" : "faq_detail");
	}
	
	//공지사항 등록폼
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/insertNotice")
	public String insertNoticeForm(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Users currentUser = (Users) authentication.getPrincipal();
		
		model.addAttribute("type", "NOTICE");
		model.addAttribute("uName", currentUser.getuName());
		model.addAttribute("uId", currentUser.getUsername());
		
		return "/insert_notice";
	}

	//FAQ 등록폼
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/insertFAQ")
	public String insertFAQForm(Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Users currentUser = (Users) authentication.getPrincipal();
		
		model.addAttribute("type", "FAQ");
		model.addAttribute("uName", currentUser.getuName());
		model.addAttribute("uId", currentUser.getUsername());
		
		return "/insert_faq";
	}

	//서버에 등록내용 전송
	@Secured({"ROLE_ADMIN"})
	@PostMapping("/admin/insertBoard")
	public String insertBoard(@ModelAttribute Board board) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Users currentUser = (Users) authentication.getPrincipal();
		
		board.setbWriter(currentUser.getuName());
		board.setuId(currentUser.getUsername());
		boardservice.insertBoard(board);
		
		return "redirect:/admin/" + (board.getbType().equals("NOTICE") ? "notice" : "faq");
	}
	
	//공지사항 수정 폼
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/editNotice")
	public String editNoticeForm(
			@RequestParam("bId") int bId,
			@RequestParam(value = "type", defaultValue = "NOTICE") String type,
			Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Users currentUser = (Users) authentication.getPrincipal();
		
		Board board = boardservice.selectBoardBid(bId);
		
		model.addAttribute("type", "FAQ");
		model.addAttribute("board", board);
		model.addAttribute("uName", currentUser.getuName());
		model.addAttribute("uId", currentUser.getUsername());
		
		return "/edit_notice";
	}

	//FAQ 수정 폼
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/editFAQ")
	public String editFAQForm(
			@RequestParam("bId") int bId,
			@RequestParam(value = "type", defaultValue = "NOTICE") String type,
			Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Users currentUser = (Users) authentication.getPrincipal();
		
		Board board = boardservice.selectBoardBid(bId);
		
		model.addAttribute("type", "FAQ");
		model.addAttribute("board", board);
		model.addAttribute("uName", currentUser.getuName());
		model.addAttribute("uId", currentUser.getUsername());
		
		return "/edit_faq";
	}
	
	// 수정된 내용 서버로 전송
	// ModelAttribute를 사용하여 Form필드의 Board객체 바인딩
	@PostMapping("/admin/updateBoard")
	public String updateBaord(@ModelAttribute Board board) {

		boardservice.updateBoard(board);
		
		return "redirect:/admin/" + (board.getbType().equals("NOTICE") ? "notice" : "faq");
	}

	@Secured({"ROLE_ADMIN"})
	@PostMapping("/admin/deleteBoard")
	public String deleteBoard(
		@RequestParam("bId") int bId,
		@RequestParam(value = "type", defaultValue = "NOTICE") String type
	) {
		Board board = boardservice.selectBoardBid(bId);
		boardservice.deleteBoard(bId);
		return "redirect:/admin/" + (board.getbType().equals("NOTICE") ? "notice" : "faq");
	}

	//관리자화면의 공지사항 리스트
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/notice")
	public String adminNotice(
		@RequestParam(value = "page", defaultValue = "1") int page,
		Model model
	) {
		int count = boardservice.countBoardByType("NOTICE");
		
		Pagination pagination = new Pagination();
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.build();

		Map<String, Object> params = new HashMap<>();
		params.put("type", "NOTICE");
		params.put("pagination", pagination);
		
		List<Board> bList = boardservice.selectBoardList(params);
		
		model.addAttribute("bList", bList);
		model.addAttribute("pagination", pagination);
		model.addAttribute("type", "NOTICE");
		
		return "/adminNotice";
	}

	//관리자화면의 FAQ
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/faq")
	public String adminFAQ(
		@RequestParam(value = "page", defaultValue = "1") int page,
		Model model
	) {
		int count = boardservice.countBoardByType("FAQ");
		
		Pagination pagination = new Pagination();
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.build();

		Map<String, Object> params = new HashMap<>();
		params.put("type", "FAQ");
		params.put("pagination", pagination);
		
		List<Board> bList = boardservice.selectBoardList(params);
		
		model.addAttribute("bList", bList);
		model.addAttribute("pagination", pagination);
		model.addAttribute("type", "FAQ");
		
		return "/adminFAQ";
	}

	//유저화면의 공지사항 리스트
	@GetMapping("/userNotice")
	public String userNotice(
		@RequestParam(value = "page", defaultValue = "1") int page,
		Model model
	) {
		int count = boardservice.countBoardByType("NOTICE");
		
		Pagination pagination = new Pagination();
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.build();

		Map<String, Object> params = new HashMap<>();
		params.put("type", "NOTICE");
		params.put("pagination", pagination);
		
		List<Board> bList = boardservice.selectBoardList(params);
		
		// 카테고리 목록 가져오기
		List<Category> cList = categoryservice.selectTierCategory();
		model.addAttribute("cList", cList);
		
		model.addAttribute("bList", bList);
		model.addAttribute("pagination", pagination);
		model.addAttribute("type", "NOTICE");
		
		return "/userNotice";
	}
	
	//유저화면의 FAQ 리스트
	@GetMapping("/userFAQ")
	public String userFAQ(
		@RequestParam(value = "page", defaultValue = "1") int page,
		Model model
	) {
		int count = boardservice.countBoardByType("FAQ");
		
		Pagination pagination = new Pagination();
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.build();

		Map<String, Object> params = new HashMap<>();
		params.put("type", "FAQ");
		params.put("pagination", pagination);
		
		List<Board> bList = boardservice.selectBoardList(params);
		
		// 카테고리 목록 가져오기
		List<Category> cList = categoryservice.selectTierCategory();
		model.addAttribute("cList", cList);
		
		model.addAttribute("bList", bList);
		model.addAttribute("pagination", pagination);
		model.addAttribute("type", "FAQ");
		
		return "/userFAQ";
	}
		
	//유저화면의 게시물 상세
	@GetMapping("/userBoardDetail")
	public String userBoardDetail(
		@RequestParam("bId") int bId,
		@RequestParam(value = "type", defaultValue = "NOTICE") String type,
		Model model
	) {
		
		Board board = boardservice.selectBoardBid(bId);
		model.addAttribute("board", board);
		model.addAttribute("type", type);
		
		return "/user_" + (type.equals("NOTICE") ? "notice_detail" : "faq_detail");
	}
}
