package com.shoppingmall.demo.domain;

public class SearchParam {
	private String searchKeyword = "";
	
	public SearchParam() {
		
	}
	
	public SearchParam(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
}
