package com.shoppingmall.demo.controller;

import com.shoppingmall.demo.domain.Payment;
import com.shoppingmall.demo.service.PaymentService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import com.shoppingmall.demo.domain.Users;
import com.shoppingmall.demo.domain.Orders;
import com.shoppingmall.demo.domain.OrderDetail;
import com.shoppingmall.demo.service.OrderService;
import com.shoppingmall.demo.service.OrderDetailService;
import com.shoppingmall.demo.service.UserService;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.security.Principal;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

    @Autowired
    PaymentService paymentservice;

    @Autowired
    OrderService orderservice;

    @Autowired
    OrderDetailService orderDetailservice;

    @Autowired
    UserService userservice;

    @GetMapping("/checkout")
    public String checkout(@RequestParam("orderId") String orderId, Model model, @AuthenticationPrincipal Users user) {
        logger.debug("Received orderId: {}", orderId);
        logger.debug("User: {}", user);
        
        if (user == null) {
            return "redirect:/";
        }
        
        Orders orders = orderservice.selectOrderById(orderId);
        logger.debug("Found order: {}", orders);
        
        if (orders == null || !orders.getUId().equals(user.getuId())) {
            return "redirect:/order/list";
        }
        
        List<OrderDetail> orderDetails = orderservice.selectOrderDetailsByOrderId(orderId);
        if (orderDetails == null || orderDetails.isEmpty()) {
            return "redirect:/order/list";
        }
        
        // 총 주문 금액 계산
        int totalPrice = orders.getTotalPrice(); // orders 테이블에 저장된 총액 사용

        model.addAttribute("user", user);
        model.addAttribute("orders", orders);
        model.addAttribute("orderDetail", orderDetails.get(0));
        model.addAttribute("totalPrice", totalPrice);
        
        return "/payment/checkout";
    }

    @GetMapping("/success")
    public String paymentSuccess(Model model, Principal principal) {
        if (principal != null) {
            Users user = userservice.readUser(principal.getName());
            model.addAttribute("user", user);
        }
        return "/payment/success";
    }

    @GetMapping("/fail")
    public String fail() {
        return "/payment/fail";
    }

    @PostMapping("/confirm")
    @ResponseBody
    public ResponseEntity<?> confirmPayment(@RequestBody Payment payment) {
        try {
            // 결제 정보 저장
            paymentservice.insertPayment(payment);

            // 결제 상태 업데이트
            paymentservice.updatePaymentStatus(payment.getPaymentId(), "COMPLETED");

            return ResponseEntity.ok("결제 성공");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("결제 실패: " + e.getMessage());
        }
    }
}