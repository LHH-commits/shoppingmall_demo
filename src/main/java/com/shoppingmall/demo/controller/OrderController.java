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

import jakarta.servlet.http.HttpSession;

import com.shoppingmall.demo.service.CartService;
import com.shoppingmall.demo.service.CategoryService;
import com.shoppingmall.demo.service.OrderDetailService;
import com.shoppingmall.demo.service.ProductService;
import com.shoppingmall.demo.service.PaymentService;
import com.shoppingmall.demo.service.ReviewService;
import com.shoppingmall.demo.service.UserService;
import com.shoppingmall.demo.service.OrderService;

import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.Payment;
import com.shoppingmall.demo.domain.Review;
import com.shoppingmall.demo.domain.Cart;
import com.shoppingmall.demo.domain.Category;
import com.shoppingmall.demo.domain.Orders;
import com.shoppingmall.demo.domain.OrderDetail;
import com.shoppingmall.demo.domain.Users;

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
    private ProductService productservice;

    @Autowired
    private ReviewService reviewservice;
    
    @Autowired
    private PaymentService paymentservice;

    @Autowired
    private OrderDetailService orderDetailService;

    // 주문서 작성 페이지(직접 결제)
    @PostMapping("/direct-checkout")
    public ResponseEntity<?> directCheckout(@RequestParam int pId, 
                                          @RequestParam int amount,
                                          Principal principal) {
        try {
            Users user = userservice.readUser(principal.getName());
            
            // 임시 장바구니에 상품 추가
            Cart tempCart = new Cart();
            tempCart.setpId(pId);
            tempCart.setCartAmount(amount);
            tempCart.setuId(user.getuId());
            tempCart.setProduct(productservice.selectProductPid(pId));
            
            List<Cart> tempCartItems = new ArrayList<>();
            tempCartItems.add(tempCart);
            
            // 세션이 아닌 Model에 데이터를 전달하기 위해 임시로 cartservice 사용
            cartservice.clearCart(user.getuId()); // 기존 장바구니 비우기
            cartservice.addToCart(tempCart);     // 임시 상품 추가
            
            logger.info("직접 결제 요청 - pId: {}, amount: {}", pId, amount);  // 로그 추가
            
            return ResponseEntity.ok().build();
            
        } catch (Exception e) {
            logger.error("직접 결제 처리 중 오류 발생: ", e);
            return ResponseEntity.badRequest().body("결제 처리 중 오류가 발생했습니다.");
        }
    }

    // 주문서 작성 페이지
    @GetMapping("/checkout")
    public String orderForm(Model model, Principal principal) {
        // 카테고리 목록 가져오기 (HomeUI.jsp에서 사용)
		List<Category> cList = categoryservice.selectTierCategory();
		model.addAttribute("cList", cList);
        
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

        // 사용자의 리뷰 목록 가져오기
        List<Review> reviews = reviewservice.getReviewsByUid(user.getuId());
        model.addAttribute("reviews", reviews);
        
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

    /*------------------------------------------------------- */
    // 관리자용 주문 관리 페이지
    @GetMapping("/admin/order")
    public String adminOrderManagement() {
        return "/order/adminOrder";
    }
    
    // 관리자용 주문 목록 조회 (Ajax 요청 처리)
    @GetMapping("/admin/orderList")
    public String getAdminOrderList(
            @RequestParam(defaultValue = "1") int page,
            Model model) {
        
        // Pagination 객체 생성 및 설정
        Pagination pagination = new Pagination();
        pagination.setPage(page);
        pagination.setCount(orderservice.getOrderCount());
        pagination.build();  // 페이지네이션 계산
        
        // 파라미터 설정
        Map<String, Object> params = new HashMap<>();
        params.put("pagination", pagination);
        
        List<OrderDetail> orders = orderservice.getOrderList(params);
        model.addAttribute("orders", orders);
        model.addAttribute("pagination", pagination);
        
        return "/order/orderList";
    }
    
    // 관리자용 주문 상태 업데이트
    @PostMapping("/admin/updateStatus")
    @ResponseBody
    public ResponseEntity<String> updateOrderStatus(
            @RequestParam("orderIds") String orderIds,
            @RequestParam("status") String status) {
        try {
            String[] ids = orderIds.split(",");
            for (String id : ids) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setoId(id);
                orderDetail.setOdDeliveryStatus(status);
                orderservice.updateOrderStatus(orderDetail);
            }
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            logger.error("주문 상태 업데이트 중 오류 발생: ", e);
            return ResponseEntity.badRequest().body("error");
        }
    }

    @GetMapping("/admin/detail")
    public String getOrderDetail(@RequestParam("oId") String oId, Model model) {
        logger.debug("Fetching order details for oId: {}", oId);
        
        try {
            // 주문 기본 정보 조회
            Orders order = orderservice.selectOrderById(oId);
            if (order == null) {
                logger.error("Order not found for oId: {}", oId);
                return "error/404";
            }
            
            // 주문 상세 정보 조회
            List<OrderDetail> orderDetails = orderservice.selectOrderDetailsByOrderId(oId);
            if (orderDetails == null || orderDetails.isEmpty()) {
                logger.error("Order details not found for oId: {}", oId);
                return "error/404";
            }
            
            // 총 주문 금액 계산
            int totalAmount = orderDetails.stream()
                    .mapToInt(detail -> detail.getOdPrice())
                    .sum();
            
            logger.debug("Order found: {}, Details count: {}, Total amount: {}", 
                        order.getoId(), orderDetails.size(), totalAmount);
            
            model.addAttribute("order", order);
            model.addAttribute("orderDetails", orderDetails);
            model.addAttribute("totalAmount", totalAmount);
            
            return "/order/orderDetailModal";
        } catch (Exception e) {
            logger.error("Error while fetching order details: ", e);
            return "error/500";
        }
    }
}
