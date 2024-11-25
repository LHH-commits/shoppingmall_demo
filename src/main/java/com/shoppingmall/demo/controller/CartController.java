package com.shoppingmall.demo.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

import com.shoppingmall.demo.service.CategoryService;
import com.shoppingmall.demo.service.ProductService;
import com.shoppingmall.demo.domain.Product;
import com.shoppingmall.demo.domain.Cart;
import com.shoppingmall.demo.domain.Category;
import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.service.CartService;
import com.shoppingmall.demo.service.UserService;

@Controller
public class CartController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	CartService cartservice;
    @Autowired
    ProductService productservice;
    @Autowired
    UserService usersservice;
    @Autowired
    CategoryService categoryservice;

    // 장바구니 페이지 보기
    @GetMapping("/user/cart")
    public String viewCart(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        String userId = userDetails.getUsername();
        // 카테고리 목록 가져오기(homeUI.jsp에서 사용)
		List<Category> cList = categoryservice.selectTierCategory();
		model.addAttribute("cList", cList);

        List<Cart> cartItems = cartservice.selectCartList(userId);
        int cartTotalPrice = cartItems.stream()
                .mapToInt(item -> item.getProduct().getpPrice() * item.getCartAmount())
                .sum();
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("cartTotalPrice", cartTotalPrice);
        return "/userCart";
    }
    
    // 장바구니에 상품 추가
    @PostMapping("/addCart")
    @ResponseBody
    public ResponseEntity<String> addToCart(
            @RequestParam("pId") int pId,
            @RequestParam(value = "cartAmount", defaultValue = "0") int cartAmount,
            @AuthenticationPrincipal UserDetails userDetails) {
        try {
            String userId = userDetails.getUsername();
            Cart cart = new Cart();
            cart.setuId(userId);
            cart.setpId(pId);
            cart.setCartAmount(cartAmount);
            
            cartservice.addToCart(cart);
            return ResponseEntity.ok("장바구니에 추가되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("로그인 후 이용해주세요.");
        }
    }

    // 장바구니 수량 업데이트
    @PostMapping("/cart/update")
    @ResponseBody
    public ResponseEntity<String> updateCartAmount(
            @RequestParam("cartId") int cartId,
            @RequestParam("amount") int amount,
            @AuthenticationPrincipal UserDetails userDetails) {
        try {
            String userId = userDetails.getUsername();
            if (amount < 1) {
                return ResponseEntity.badRequest().body("수량은 1개 이상이어야 합니다.");
            }
            cartservice.updateCartAmount(cartId, userId, amount);
            return ResponseEntity.ok("수량이 업데이트되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("수량 업데이트 실패");
        }
    }

    // 장바구니 개별 상품 삭제
    @PostMapping("/cart/remove")
    @ResponseBody
    public ResponseEntity<String> removeFromCart(
            @RequestParam("cartId") int cartId,
            @AuthenticationPrincipal UserDetails userDetails) {
        try {
            String userId = userDetails.getUsername();
            cartservice.removeFromCart(cartId, userId);
            return ResponseEntity.ok("상품이 삭제되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("상품 삭제 실패");
        }
    }

    // 장바구니 비우기
    @PostMapping("/cart/clear")
    @ResponseBody
    public ResponseEntity<String> clearCart(@AuthenticationPrincipal UserDetails userDetails) {
        try {
            String userId = userDetails.getUsername();
            cartservice.clearCart(userId);
            return ResponseEntity.ok("장바구니가 비워졌습니다.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("장바구니 비우기 실패");
        }
    }

    @GetMapping("/cart/count")
    @ResponseBody
    public int getCartCount(@AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails != null) {
            String userId = userDetails.getUsername();
            return cartservice.cartItemCount(userId);
        }
        return 0;
    }
}
