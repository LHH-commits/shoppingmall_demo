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
import java.util.List;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    PaymentService paymentservice;

    @Autowired
    OrderService orderservice;

    @Autowired
    OrderDetailService orderDetailservice;

    @GetMapping("/checkout")
    public String checkout(@RequestParam("orderId") int orderId, Model model, @AuthenticationPrincipal Users user) {
        if (user == null) {
            return "redirect:/";
        }
        
        Orders orders = orderservice.selectOrderById(orderId);
        if (orders == null || !orders.getUId().equals(user.getuId())) {
            return "redirect:/order/list";
        }
        
        List<OrderDetail> orderDetails = orderservice.selectOrderDetailsByOrderId(orderId);
        if (orderDetails == null || orderDetails.isEmpty()) {
            return "redirect:/order/list";
        }
        
        model.addAttribute("user", user);
        model.addAttribute("orders", orders);
        model.addAttribute("orderDetail", orderDetails.get(0));
        
        return "/payment/checkout";
    }

    @GetMapping("/success")
    public String success() {
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