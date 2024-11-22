package com.shoppingmall.demo.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.shoppingmall.demo.domain.Category;

@Mapper
public interface CategoryMapper {
	public List<Category> selectCategoryList();
	
	public Category selectCategoryById(int cateId);
	
	public void insertCategory(Category category);
	
	public void deleteCategory(int cateId);
	
	public void updateCategory(Category category);
	
	public List<Category> selectSubCategories(Map<String, Integer> params);
	
	public List<Category> selectTierCategory();
	
	public List<Category> selectAllSubCategories(int cateId);
}
