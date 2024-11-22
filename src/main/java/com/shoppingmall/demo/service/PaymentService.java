package com.shoppingmall.demo.service;

import com.shoppingmall.demo.domain.Payment;
import java.util.List;

public interface PaymentService {
    // 결제 정보 저장
    void insertPayment(Payment payment);
    
    // 결제 정보 조회
    Payment selectPaymentById(String paymentId);
    Payment selectPaymentByOrderId(int oId);
    List<Payment> selectPaymentsByUserId(String uId);
    
    // 결제 상태 업데이트
    void updatePaymentStatus(String paymentId, String status);
}
