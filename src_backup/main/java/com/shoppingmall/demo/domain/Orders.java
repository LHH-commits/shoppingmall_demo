package com.shoppingmall.demo.domain;

import com.shoppingmall.demo.domain.Product;
import com.shoppingmall.demo.domain.Users;

public class Orders {
	private int oId;
	private String oInfo;
	private String oDatetime;
	private String oAddress;
	private String uId;
	private Users user;
	private Product product;
	
	public int getoId() {
		return oId;
	}
	public void setoId(int oId) {
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
	
	
}
