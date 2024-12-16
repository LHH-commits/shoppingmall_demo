package com.shoppingmall.demo.domain;

import java.util.Date;
import java.util.List;

public class Dashboard {
    // 일일 통계
    private int todayOrders;
    private int todaySales;
    private int newMembers;
    
    // 주문 관련
    private String oId;            // Orders.java 참고
    private Date oDatetime;        // Orders.java 참고
    private String uName;          // Users.java의 이름
    private int totalPrice;        // Orders.java 참고
    private String odDeliveryStatus;  // OrderDetail.java 참고
    
    // 상품 관련
    private String pName;          // Product.java 참고
    private int pPrice;            // Product.java 참고
    private String catePath;       // Product.java 참고
    private int odCount;           // OrderDetail.java 참고
    private int odPrice;           // OrderDetail.java 참고
    
    // 공지사항 관련
    private int bId;               // Board.java 참고
    private String bTitle;         // Board.java 참고
    private String bDatetime;      // Board.java 참고
    private int bViews;            // Board.java 참고
    private String bWriter;        // Board.java 참고

    // getter, setter 메서드들
    public int getTodayOrders() {
        return todayOrders;
    }
    public void setTodayOrders(int todayOrders) {
        this.todayOrders = todayOrders;
    }
    public int getTodaySales() {
        return todaySales;
    }
    public void setTodaySales(int todaySales) {
        this.todaySales = todaySales;
    }
    public int getNewMembers() {
        return newMembers;
    }
    public void setNewMembers(int newMembers) {
        this.newMembers = newMembers;
    }
    public String getoId() {
        return oId;
    }
    public void setoId(String oId) {
        this.oId = oId;
    }
    public Date getoDatetime() {
        return oDatetime;
    }
    public void setoDatetime(Date oDatetime) {
        this.oDatetime = oDatetime;
    }
    public String getuName() {
        return uName;
    }
    public void setuName(String uName) {
        this.uName = uName;
    }
    public int getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }
    public String getOdDeliveryStatus() {
        return odDeliveryStatus;
    }
    public void setOdDeliveryStatus(String odDeliveryStatus) {
        this.odDeliveryStatus = odDeliveryStatus;
    }
    public String getpName() {
        return pName;
    }
    public void setpName(String pName) {
        this.pName = pName;
    }
    public int getpPrice() {
        return pPrice;
    }
    public void setpPrice(int pPrice) {
        this.pPrice = pPrice;
    }
    public String getCatePath() {
        return catePath;
    }
    public void setCatePath(String catePath) {
        this.catePath = catePath;
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
    public int getbId() {
        return bId;
    }
    public void setbId(int bId) {
        this.bId = bId;
    }
    public String getbTitle() {
        return bTitle;
    }
    public void setbTitle(String bTitle) {
        this.bTitle = bTitle;
    }
    public String getbDatetime() {
        return bDatetime;
    }
    public void setbDatetime(String bDatetime) {
        this.bDatetime = bDatetime;
    }
    public int getbViews() {
        return bViews;
    }
    public void setbViews(int bViews) {
        this.bViews = bViews;
    }
    public String getbWriter() {
        return bWriter;
    }
    public void setbWriter(String bWriter) {
        this.bWriter = bWriter;
    }
    
} 