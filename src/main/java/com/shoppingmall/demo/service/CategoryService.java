package com.shoppingmall.demo.service;

import java.util.List;
import java.util.Map;

import com.shoppingmall.demo.domain.Category;

public interface CategoryService {
	public List<Category> selectCategoryList();
	
	public Category selectCategoryById(int cateId);
	
	public void insertCategory(Category category);
	
	public void deleteCategory(int cateId);
	
	public void updateCategory(Category category);
	
	public List<Category> selectSubCategories(Map<String, Integer> params);
	
	public List<Category> selectTierCategory();
	
	public List<Integer> getSubCategoryIds(int cateId);
	
	public List<Category> selectAllSubCategories(int cateId);
	
	public List<Category> getCategoryPath(int cateId);
}
