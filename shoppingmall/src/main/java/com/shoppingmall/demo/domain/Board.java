package com.shoppingmall.demo.domain;

import com.shoppingmall.demo.domain.Users;

public class Board {
	private int bId;			//b_id
	private String bTitle;		//b_title
	private String bContent;	//b_content
	private int bViews;			//b_views
	private String bDatetime;	//b_datetime
	private String bWriter;		//b_writer
	private String bType;		//b_type
	private Users user;			//u_id를 가져오기 위한 user객체
	private String uId;		// u_id 필드 추가

	public String getbType() {
		return bType;
	}
	public void setbType(String bType) {
		this.bType = bType;
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
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public int getbViews() {
		return bViews;
	}
	public void setbViews(int bViews) {
		this.bViews = bViews;
	}
	public String getbDatetime() {
		return bDatetime;
	}
	public void setbDatetime(String bDatetime) {
		this.bDatetime = bDatetime;
	}
	public String getbWriter() {
		return bWriter;
	}
	public void setbWriter(String bWriter) {
		this.bWriter = bWriter;
	}
	
	// 유저 정보 가져오기(u_id)
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	}
	public String getuId() {
		return uId;
	}
	public void setuId(String uId) {
		this.uId = uId;
	}
	
}
