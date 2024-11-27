package com.shoppingmall.demo.domain;

import java.util.Date;

public class Review {
	private int rId;
	private String rContent;
	private int rScore;
	private String rWriter;
	private int pId;
	private String uId;
	private Date rDatetime;
	
	private Product product;
	private Users user;
	
	public Date getrDatetime() {
		return rDatetime;
	}
	public void setrDatetime(Date rDatetime) {
		this.rDatetime = rDatetime;
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	public int getrId() {
		return rId;
	}
	public void setrId(int rId) {
		this.rId = rId;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public int getrScore() {
		return rScore;
	}
	public void setrScore(int rScore) {
		this.rScore = rScore;
	}
	public String getrWriter() {
		return rWriter;
	}
	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
}
