package com.shoppingmall.demo.domain;

import java.util.List;

import com.shoppingmall.demo.domain.Category;

public class Product {
	private int pId;		//p_id (PK)
	private int pPrice;		//p_price (상품 가격)
	private String pSeller;	//p_seller (판매자)
	private String pStock;	//p_stock (상품 수량 / 많음, 품절, 잔여수량)
	private String pUptime; //p_uptime (상품 등록일)
	private String pName;	//p_name (상품명)
	private Category category;	//category_id, category_name 사용할때 쓸 것(후에 업데이트 예정)
	private String pImgpath;	//p_imgpath (상품 이미지 경로)
	private Integer cateId;		//category_id
	private String catePath;
	private String pDetail;
	
	public String getpDetail() {
		return pDetail;
	}
	public void setpDetail(String pDetail) {
		this.pDetail = pDetail;
	}
	public String getpImgpath() {
		return pImgpath;
	}
	public void setpImgpath(String pImgpath) {
		this.pImgpath = pImgpath;
	}
	public String getCatePath() {
		return catePath;
	}
	public void setCatePath(String catePath) {
		this.catePath = catePath;
	}
	public Integer getCateId() {
		return cateId;
	}
	public void setCateId(Integer cateId) {
		this.cateId = cateId;
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public int getpPrice() {
		return pPrice;
	}
	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}
	public String getpSeller() {
		return pSeller;
	}
	public void setpSeller(String pSeller) {
		this.pSeller = pSeller;
	}
	public String getpStock() {
		return pStock;
	}
	public void setpStock(String pStock) {
		this.pStock = pStock;
	}
	public String getpUptime() {
		return pUptime;
	}
	public void setpUptime(String pUptime) {
		this.pUptime = pUptime;
	}
	public Category getCategory() {
		return category;
	}
	public void setCategory(Category category) {
		this.category = category;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	
	
}
