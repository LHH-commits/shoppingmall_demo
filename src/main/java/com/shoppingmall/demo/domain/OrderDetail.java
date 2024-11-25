package com.shoppingmall.demo.domain;

import com.shoppingmall.demo.domain.Orders;
import com.shoppingmall.demo.domain.Product;

public class OrderDetail {
    private int odId;
    private String oId;
    private int pId;
    private int odCount;    // 주문 상품 수량(개수)
    private int odPrice;    // 주문 상품 가격(총액)
    private Orders orders;
    private Product product;
    private Payment payment;
    
    public int getOdId() {
        return odId;
    }
    public void setOdId(int odId) {
        this.odId = odId;
    }
    public String getoId() {
        return oId;
    }
    public void setoId(String oId) {
        this.oId = oId;
    }
    public int getpId() {
        return pId;
    }
    public void setpId(int pId) {
        this.pId = pId;
    }
    public int getOdCount() {
        return odCount;
    }
    public void setOdCount(int odCount) {
        this.odCount = odCount;
    }
    public int getOdPrice() {
        return odPrice;
    }
    public void setOdPrice(int odPrice) {
        this.odPrice = odPrice;
    }
    public Orders getOrders() {
        return orders;
    }
    public void setOrders(Orders orders) {
        this.orders = orders;
    }
    public Product getProduct() {
        return product;
    }
    public void setProduct(Product product) {
        this.product = product;
    }
    public Payment getPayment() {
        return payment;
    }
    public void setPayment(Payment payment) {
        this.payment = payment;
    }
}
