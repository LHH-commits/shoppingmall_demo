package com.shoppingmall.demo.domain;

import com.shoppingmall.demo.domain.Product;
import com.shoppingmall.demo.domain.Users;
import java.time.LocalDateTime;
import java.util.List;

public class Orders {
	private String oId;
	private String oInfo;
	private String oDatetime;
	private String oAddress;
	private String uId;
	private Users user;
	private Product product;

	
	private Payment payment;
	private List<OrderDetail> orderDetails;
	
	private int totalAmount;
	
	private String paymentStatus;
	
	private String paymentType;
	
	private LocalDateTime paymentTime;
	
	public String getoId() {
		return oId;
	}
	public void setoId(String oId) {
		this.oId = oId;
	}
	public String getoInfo() {
		return oInfo;
	}
	public void setoInfo(String oInfo) {
		this.oInfo = oInfo;
	}
	public String getoDatetime() {
		return oDatetime;
	}
	public void setoDatetime(String oDatetime) {
		this.oDatetime = oDatetime;
	}
	public String getoAddress() {
		return oAddress;
	}
	public void setoAddress(String oAddress) {
		this.oAddress = oAddress;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public String getUId() {
		return uId;
	}
	public void setUId(String uId) {
		this.uId = uId;
	}
	public List<OrderDetail> getOrderDetails() {
		return orderDetails;
	}
	public void setOrderDetails(List<OrderDetail> orderDetails) {
		this.orderDetails = orderDetails;
	}
	public int getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public LocalDateTime getPaymentTime() {
		return paymentTime;
	}
	public void setPaymentTime(LocalDateTime paymentTime) {
		this.paymentTime = paymentTime;
	}
	public Payment getPayment() {
		return payment;
	}
	public void setPayment(Payment payment) {
		this.payment = payment;
	}
}
