package com.shoppingmall.demo.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shoppingmall.demo.domain.Payment;

import java.util.List;

@Mapper
public interface PaymentMapper {
    // 결제 정보 저장
    public void insertPayment(Payment payment);
    
    // 결제 정보 조회
    public Payment selectPaymentById(String paymentId);
    public Payment selectPaymentByOrderId(String oId);
    public List<Payment> selectPaymentsByUserId(String uId);
    
    // 결제 상태 업데이트
    public void updatePaymentStatus(@Param("paymentId") String paymentId, 
                           @Param("status") String status);
}
