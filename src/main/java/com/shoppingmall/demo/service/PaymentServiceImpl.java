package com.shoppingmall.demo.service;

import com.shoppingmall.demo.domain.Payment;
import com.shoppingmall.demo.mapper.PaymentMapper;
import com.shoppingmall.demo.service.PaymentService;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {
    @Autowired
    PaymentMapper paymentmapper;
    
    // 결제 정보 저장
    @Override
    public void insertPayment(Payment payment) {
        paymentmapper.insertPayment(payment);
    }
    
    // 결제 정보 조회
    @Override
    public Payment selectPaymentById(String paymentId) {
        return paymentmapper.selectPaymentById(paymentId);
    }
    @Override
    public Payment selectPaymentByOrderId(String oId) {
        return paymentmapper.selectPaymentByOrderId(oId);
    }
    @Override
    public List<Payment> selectPaymentsByUserId(String uId) {
        return paymentmapper.selectPaymentsByUserId(uId);
    }
    
    // 결제 상태 업데이트
    @Override
    public void updatePaymentStatus(String paymentId, String status) {
        paymentmapper.updatePaymentStatus(paymentId, status);
    }
}
