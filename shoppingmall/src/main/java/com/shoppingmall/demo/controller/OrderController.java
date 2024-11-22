package com.shoppingmall.demo.controller;

import java.security.Principal;
import java.util.List;
import java.util.UUID;
import java.util.HashMap;
import java.util.Map;
import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.shoppingmall.demo.service.OrderService;
import com.shoppingmall.demo.domain.Orders;
import com.shoppingmall.demo.domain.OrderDetail;
import com.shoppingmall.demo.domain.Users;
import com.shoppingmall.demo.service.UserService;
import com.shoppingmall.demo.domain.Cart;
import com.shoppingmall.demo.domain.Category;
import com.shoppingmall.demo.service.CartService;
import com.shoppingmall.demo.service.CategoryService;
import com.shoppingmall.demo.service.OrderDetailService;
import com.shoppingmall.demo.service.PaymentService;
import com.shoppingmall.demo.domain.Payment;

@Controller
@RequestMapping("/order")
public class OrderController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Autowired
    private OrderService orderservice;
    
    @Autowired
    private UserService userservice;
    
    @Autowired
    private CartService cartservice;

    @Autowired
    private CategoryService categoryservice;

    @Autowired
    private PaymentService paymentservice;

    @Autowired
    private OrderDetailService orderDetailService;

    // 주문서 작성 페이지
    @GetMapping("/checkout")
    public String orderForm(Model model, Principal principal) {
        Users user = userservice.readUser(principal.getName());
        List<Cart> cartItems = cartservice.selectCartList(user.getuId());
        
        if (cartItems == null || cartItems.isEmpty()) {
            return "redirect:/cart?message=empty";
        }
        
        int totalPrice = cartservice.cartTotalPrice(user.getuId());
        
        model.addAttribute("user", user);
        model.addAttribute("cartItems", cartItems);
        model.addAttribute("totalPrice", totalPrice);
        
        return "/order/checkout";
    }

    // 주문 처리
    @PostMapping("/place")
    @ResponseBody
    public ResponseEntity<Map<String, String>> placeOrder(@RequestBody Orders order, Principal principal) {
        Users user = userservice.readUser(principal.getName());
        order.setUId(user.getuId());
        
        // UUID로 oId 생성
        String oId = UUID.randomUUID().toString();
        order.setoId(oId);
        
        try {
            // 주문 생성
            orderservice.insertOrder(order);
            
            // 장바구니 상품들을 주문상세에 추가
            List<Cart> cartItems = cartservice.selectCartList(user.getuId());
            for (Cart cart : cartItems) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setoId(oId);
                orderDetail.setpId(cart.getpId());
                orderDetail.setOdCount(cart.getCartAmount());
                orderDetail.setOdPrice(cart.getProduct().getpPrice() * cart.getCartAmount());
                orderservice.insertOrderDetail(orderDetail);
            }
            
            // 장바구니 비우기
            cartservice.clearCart(user.getuId());
            
            // 생성된 주문 ID를 응답으로 전송
            Map<String, String> response = new HashMap<>();
            response.put("oId", oId);
            
            logger.debug("Response payload: {}", response);  // 응답 데이터 로깅
            
            return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(response);
            
        } catch (Exception e) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", e.getMessage());
            return ResponseEntity.badRequest().body(errorResponse);
        }
    }

    // 주문 완료 페이지
    @GetMapping("/complete")
    public String orderComplete(@RequestParam("orderId") String orderId, Model model) {
        Orders order = orderservice.selectOrderById(orderId);
        List<OrderDetail> orderDetails = orderservice.selectOrderDetailsByOrderId(orderId);
        
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        return "/order/complete";
    }

    // 주문 목록 조회
    @GetMapping("/list")
    public String orderList(Principal principal, Model model) {
        // 카테고리 목록 가져오기(homeUI.jsp에서 사용)
		List<Category> cList = categoryservice.selectTierCategory();
		model.addAttribute("cList", cList);
        
        Users user = userservice.readUser(principal.getName());
        List<OrderDetail> orderDetails = orderservice.selectOrdersWithDetailsByUId(user.getuId());
        
        // OrderDetail 목록을 Orders 기준으로 그룹화
        Map<String, Orders> orderMap = new HashMap<>();
        
        for (OrderDetail detail : orderDetails) {
            Orders order = orderMap.computeIfAbsent(detail.getoId(), k -> {
                Orders newOrder = detail.getOrders();  // Orders 정보 가져오기
                newOrder.setOrderDetails(new ArrayList<>());
                newOrder.setTotalAmount(0);
                return newOrder;
            });
            
            order.getOrderDetails().add(detail);
            order.setTotalAmount(order.getTotalAmount() + detail.getOdPrice());
            
            // Payment 정보 설정
            if (detail.getPayment() != null) {
                order.setPaymentStatus(detail.getPayment().getStatus());
                order.setPaymentType(detail.getPayment().getPaymentType());
                order.setPaymentTime(detail.getPayment().getPaymentTime());
            }
        }
        
        // 주문 목록을 날짜순으로 정렬
        List<Orders> sortedOrders = new ArrayList<>(orderMap.values());
        sortedOrders.sort((o1, o2) -> o2.getoDatetime().compareTo(o1.getoDatetime()));
        
        model.addAttribute("orders", sortedOrders);
        return "/order/list";
    }

    // 주문 상세 조회
    @GetMapping("/detail/{orderId}")
    public String orderDetail(@PathVariable("orderId") String orderId, Model model, Principal principal) {
        Orders order = orderservice.selectOrderById(orderId);
        Users user = userservice.readUser(principal.getName());
        
        if (!order.getUId().equals(user.getuId())) {
            return "redirect:/error/unauthorized";
        }
        
        List<OrderDetail> orderDetails = orderservice.selectOrderDetailsByOrderId(orderId);
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        return "/order/detail";
    }

    // 주문 취소
    @PostMapping("/cancel/{orderId}")
    public String cancelOrder(@PathVariable("orderId") String orderId, Principal principal) {
        Orders order = orderservice.selectOrderById(orderId);
        Users user = userservice.readUser(principal.getName());
        
        if (!order.getUId().equals(user.getuId())) {
            return "redirect:/error/unauthorized";
        }
        
        try {
            orderservice.deleteOrderDetail(orderId);
            orderservice.deleteOrder(orderId);
            return "redirect:/order/list?message=cancelled";
        } catch (Exception e) {
            logger.error("주문 취소 중 오류 발생: ", e);
            return "redirect:/order/list?error=true";
        }
    }

    // 주문 정보 수정
    @PostMapping("/update/{orderId}")
    public String updateOrder(
        @PathVariable("orderId") String orderId,
        @ModelAttribute Orders updateOrder,
        Principal principal
    ) {
        Orders order = orderservice.selectOrderById(orderId);
        Users user = userservice.readUser(principal.getName());
        
        if (!order.getUId().equals(user.getuId())) {
            return "redirect:/error/unauthorized";
        }
        
        try {
            updateOrder.setoId(orderId);
            orderservice.updateOrder(updateOrder);
            return "redirect:/order/detail/" + orderId + "?message=updated";
        } catch (Exception e) {
            logger.error("주문 정보 수정 중 오류 발생: ", e);
            return "redirect:/order/detail/" + orderId + "?error=true";
        }
    }
}
