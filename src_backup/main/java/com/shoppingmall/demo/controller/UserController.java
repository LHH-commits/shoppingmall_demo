package com.shoppingmall.demo.controller;

import java.util.Collection;
import java.util.List;

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

import com.shoppingmall.demo.service.CategoryService;
import com.shoppingmall.demo.service.ProductService;
import com.shoppingmall.demo.service.UserService;
import com.shoppingmall.demo.domain.Users;
import com.shoppingmall.demo.domain.Category;
import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.Product;

@Controller
public class UserController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired 
	UserService userservice;
	@Autowired
	ProductService productservice;
	@Autowired
	CategoryService categoryservice;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@GetMapping("/")
	public String home() {
		return "/login";
	}
	
	@GetMapping("/index")
	public String choosePage() {
		return "/index";
	}
	
	@GetMapping("/loginSuccess")
	public String loginSuccessPage( Authentication authentication) {
		// 디버그 확인용 코드
		logger.info("User Authorities: {}", authentication.getAuthorities());
		// 관리자 권한이라면 /index 페이지를 보여준다
		if(authentication.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN"))) {
			return "/index";
		}
		return "/userHome";
	}
	
	@GetMapping("/adminBeforesignup")
	public String adminSignupForm(Model model) {
		return "/adminSignup";
	}
	
	@PostMapping("/adminSignup")
	public String adminSignup(@ModelAttribute Users user) {
		// 비밀번호 암호화하기
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		
		// 유저 데이터 세팅
		user.setuPassword(encodedPassword);
		user.setAccountNonExpired(true);
		user.setEnabled(true);
		user.setAccountNonLocked(true);
		user.setCredentialsNonExpired(true);
		user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_ADMIN"));
		
		userservice.insertUser(user);
		
		userservice.createAuthority(user);
		
		return "redirect:/";
	}
	
	@GetMapping("/admin/main")
	public String adminMainPage(Model model) {
		return "/adminMain";
	}
	
	@GetMapping("/userBeforesignup")
	public String userSignupForm() {
		return "/userSignup";
	}
	
	@PostMapping("/userSignup")
	public String userSignup(@ModelAttribute Users user) {
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		
		user.setuPassword(encodedPassword);
		user.setAccountNonExpired(true);
		user.setEnabled(true);
		user.setAccountNonLocked(true);
		user.setCredentialsNonExpired(true);
		user.setAuthorities(AuthorityUtils.createAuthorityList("ROLE_USER"));
		
		userservice.insertUser(user);
		userservice.createAuthority(user);
		
		return "redirect:/";
	}
	
	@GetMapping("/userHome")
	public String userHome(Model model) {
		// 카테고리 목록 가져오기
		List<Category> cList = categoryservice.selectTierCategory();
		model.addAttribute("cList", cList);
		
		// 상품 목록도 함께 가져오기 (필요한 경우)
		List<Product> pList = productservice.getAllProducts();
		model.addAttribute("pList", pList);
		
		return "/userHome";
}
	
	@GetMapping("/admin/users")
	public String manageUsers(Model model) {
		return "/adminUsers";
	}
	
	@GetMapping("/userList")
	public String loadUserList(@RequestParam(value="page", defaultValue="1") int page, Model model) {
		int count=0;
		Pagination pagination = new Pagination();
		
		count = userservice.countUsers();
		
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.build();
		
		List<Users> uList = userservice.selectUserList(pagination);
		
		model.addAttribute("uList", uList);
		model.addAttribute("pagination", pagination);
		
		return "/userList";
	}

}
