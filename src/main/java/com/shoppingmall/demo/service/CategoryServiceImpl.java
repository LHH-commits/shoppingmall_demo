package com.shoppingmall.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingmall.demo.domain.Category;
import com.shoppingmall.demo.mapper.CategoryMapper;

@Service
public class CategoryServiceImpl implements CategoryService {
	@Autowired
	CategoryMapper categorymapper;
	
	@Override
	public List<Category> selectCategoryList() {
		return categorymapper.selectCategoryList();
	}
	
	@Override
	public Category selectCategoryById(int cateId) {
		return categorymapper.selectCategoryById(cateId);
	}
	
	@Override
	public void insertCategory(Category category) {
		categorymapper.insertCategory(category);
	}
	
	@Override
	public void deleteCategory(int cateId) {
		categorymapper.deleteCategory(cateId);
	}
	
	@Override
	public void updateCategory(Category category) {
		categorymapper.updateCategory(category);
	}
	
	@Override
    public List<Category> selectSubCategories(Map<String, Integer> params) {
        return categorymapper.selectSubCategories(params);
    }
	
	@Override
	public List<Integer> getSubCategoryIds(int cateId) {
		List<Category> subCategories = categorymapper.selectAllSubCategories(cateId);
		
		return subCategories.stream()
				.map(Category::getCateId)
				.collect(Collectors.toList());
	}
	
	@Override
	public List<Category> selectTierCategory() {
		return categorymapper.selectTierCategory();
	}
	
	@Override
	public List<Category> selectAllSubCategories(int cateId) {
		return categorymapper.selectAllSubCategories(cateId);
	}
	
	@Override
	public List<Category> getCategoryPath(int cateId) {
		return categorymapper.getCategoryPath(cateId);
	}
}
