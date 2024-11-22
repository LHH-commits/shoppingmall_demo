package com.shoppingmall.demo.domain;

public class Category {
	private Integer cateId;		// category_id
	private String cateName;// category_name
	private Integer parentId;	// parent_id (무한 카테로리를 위한 컬럼) , null허용을 위해 int대신 Integer사용
	// * 최상위 분류는 parent_id가 NULL *
	private String path;
	
	public Integer getCateId() {
		return cateId;
	}
	public void setCateId(Integer cateId) {
		this.cateId = cateId;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
}
