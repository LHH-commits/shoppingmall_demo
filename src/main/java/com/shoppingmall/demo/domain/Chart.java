package com.shoppingmall.demo.domain;

import java.util.Date;

public class Chart {
    private Date orderDate;          // 주문 날짜
    private int orderCount;          // 주문 건수
    private int totalSales;          // 총 매출액
    private String productName;      // 상품명
    private int productPrice;        // 상품 가격
    private String categoryPath;     // 카테고리 경로
    private int totalQuantity;       // 총 판매수량
    private double avgRating;        // 평균 평점
    
    // Getters and Setters
    public Date getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    
    public int getOrderCount() {
        return orderCount;
    }
    public void setOrderCount(int orderCount) {
        this.orderCount = orderCount;
    }
    
    public int getTotalSales() {
        return totalSales;
    }
    public void setTotalSales(int totalSales) {
        this.totalSales = totalSales;
    }
    
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }
    
    public int getProductPrice() {
        return productPrice;
    }
    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }
    
    public String getCategoryPath() {
        return categoryPath;
    }
    public void setCategoryPath(String categoryPath) {
        this.categoryPath = categoryPath;
    }
    
    public int getTotalQuantity() {
        return totalQuantity;
    }
    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }
    
    public double getAvgRating() {
        return avgRating;
    }
    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }
}
