package com.shoppingmall.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shoppingmall.demo.service.CategoryService;
import com.shoppingmall.demo.domain.Category;

@Controller
public class CategoryController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	CategoryService categoryservice;
	
	@GetMapping("/admin/category")
	public String manageCategory(Model model) {
		List<Category> tierCategory = categoryservice.selectTierCategory();
		
		List<Category> topCategory = tierCategory.stream()
				.filter(c -> c.getParentId() == null)
				.collect(Collectors.toList());
		
		model.addAttribute("tierCategory",tierCategory);
		model.addAttribute("topCategory", topCategory);
		return "/adminCategory";
	}
	
	@PostMapping("/admin/insertCategory")
	public String insertCategory(@ModelAttribute Category category) {
		if (category.getParentId() == null || category.getParentId() == 0) {
			category.setParentId(null);
		}
		
		categoryservice.insertCategory(category);
		
		return "redirect:/admin/category";
	}
	
	// 카테고리 수정
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/editCategory")
	public String editCategory(@RequestParam("cateId") int cateId, Model model) {
		Category category = categoryservice.selectCategoryById(cateId);
	    List<Category> tierCategory = categoryservice.selectTierCategory();
	    
	    // 최상위 카테고리 필터링
	    List<Category> topCategory = tierCategory.stream()
	            .filter(c -> c.getParentId() == null)
	            .collect(Collectors.toList());
		
	    model.addAttribute("topCategory", topCategory);
		model.addAttribute("category", category);
		
		return "/edit_category";
	}
	
	@PostMapping("/admin/updateCategory")
	public String updateCategory(@ModelAttribute Category category) {
		/*
		 * // 선택한 카테고리의 ID를 parentId로 설정 if (category.getParentId() != null) { // 이동하려는
		 * 카테고리의 parentId를 설정 category.setParentId(category.getParentId()); }
		 */
		
		categoryservice.updateCategory(category);
		
		return "redirect:/admin/category";
	}
	
	@PostMapping("/admin/deleteCategory")
	public String deleteCategory(@RequestParam("cateId") int cateId) {
		categoryservice.deleteCategory(cateId);
		
		return "redirect:/admin/category";
	}
	
	@GetMapping("/api/categories/options")
    public String getSubCategoryOptions(@RequestParam("parentId") Integer parentId, 
    		@RequestParam(value = "excludeId", required = false) Integer excludeId, Model model) {
		Map<String, Integer> params = new HashMap<>();
	    params.put("parentId", parentId);
	    params.put("excludeId", excludeId);
	    
	    List<Category> subCategories = categoryservice.selectSubCategories(params);
        
        model.addAttribute("subCategories", subCategories);
        
        // options.jsp를 렌더링하여 HTML 옵션 태그들만 반환
        return "/category_options";
    }
}
