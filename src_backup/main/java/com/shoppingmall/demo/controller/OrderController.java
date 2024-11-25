package com.shoppingmall.demo.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.shoppingmall.demo.service.OrderService;
import com.shoppingmall.demo.domain.Orders;
import com.shoppingmall.demo.domain.OrderDetail;
import com.shoppingmall.demo.domain.Users;
import com.shoppingmall.demo.service.UserService;
import com.shoppingmall.demo.domain.Cart;
import com.shoppingmall.demo.service.CartService;

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

    // 주문서 작성 페이지
    @GetMapping("/checkout")
    public String orderForm(Model model, Principal principal) {
        Users user = userservice.readUser(principal.getName());
        List<Cart> cartItems = cartservice.selectCartList(user.getuId());
        
        if (cartItems == null || cartItems.isEmpty()) {
            return "redirect:/user/cart";
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
    public ResponseEntity<?> placeOrder(@RequestBody Orders order, Principal principal) {
        Users user = userservice.readUser(principal.getName());
        order.setUId(user.getuId());
        
        try {
            orderservice.insertOrder(order);
            // 장바구니에서 주문한 상품들을 주문상세에 추가
            List<Cart> cartItems = cartservice.selectCartList(user.getuId());
            for (Cart cart : cartItems) {
                OrderDetail orderDetail = new OrderDetail();
                orderDetail.setoId(order.getoId());
                orderDetail.setpId(cart.getpId());
                orderDetail.setOdCount(cart.getCartAmount());
                orderDetail.setOdPrice(cart.getProduct().getpPrice() * cart.getCartAmount());
                orderservice.insertOrderDetail(orderDetail);
            }
            
            cartservice.clearCart(user.getuId());
            
            return ResponseEntity.ok(order);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 주문 완료 페이지
    @GetMapping("/complete")
    public String orderComplete(@RequestParam("orderId") int orderId, Model model) {
        Orders order = orderservice.selectOrderById(orderId);
        List<OrderDetail> orderDetails = orderservice.selectOrderDetailsByOrderId(orderId);
        
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        return "/order/complete";
    }

    // 주문 목록 조회
    @GetMapping("/list")
    public String orderList(Principal principal, Model model) {
        Users user = userservice.readUser(principal.getName());
        List<Orders> orders = orderservice.selectOrdersByUId(Integer.parseInt(user.getuId()));
        model.addAttribute("orders", orders);
        return "/order/list";
    }

    // 주문 상세 조회
    @GetMapping("/detail/{orderId}")
    public String orderDetail(@PathVariable("orderId") int orderId, Model model, Principal principal) {
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
    public String cancelOrder(@PathVariable("orderId") int orderId, Principal principal) {
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
        @PathVariable("orderId") int orderId,
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
