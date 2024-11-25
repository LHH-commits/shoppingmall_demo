package com.shoppingmall.demo.domain;

import java.time.LocalDateTime;

public class Payment {
    private String paymentId;      // 토스 paymentKey
    private String oId;              // orders의 o_id
    private String uId;           // users의 u_id
    private int amount;
    private String paymentType;
    private String status;
    private LocalDateTime paymentTime;
    private LocalDateTime createdAt;
    
    // Orders, Users 객체 참조를 위한 필드
    private Orders order;
    private Users user;
    
    public String getPaymentId() {
        return paymentId;
    }
    public void setPaymentId(String paymentId) {
        this.paymentId = paymentId;
    }
    public String getoId() {
        return oId;
    }
    public void setoId(String oId) {
        this.oId = oId;
    }
    public String getuId() {
        return uId;
    }
    public void setuId(String uId) {
        this.uId = uId;
    }
    public int getAmount() {
        return amount;
    }
    public void setAmount(int amount) {
        this.amount = amount;
    }
    public String getPaymentType() {
        return paymentType;
    }
    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public LocalDateTime getPaymentTime() {
        return paymentTime;
    }
    public void setPaymentTime(LocalDateTime paymentTime) {
        this.paymentTime = paymentTime;
    }
    public LocalDateTime getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    public Orders getOrder() {
        return order;
    }
    public void setOrder(Orders order) {
        this.order = order;
    }
    public Users getUser() {
        return user;
    }
    public void setUser(Users user) {
        this.user = user;
    }
}
