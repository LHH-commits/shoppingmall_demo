package com.shoppingmall.demo.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.security.access.annotation.Secured;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import com.shoppingmall.demo.service.CategoryService;
import com.shoppingmall.demo.service.ProductService;
import com.shoppingmall.demo.domain.Product;
import com.shoppingmall.demo.config.FileConfig;
import com.shoppingmall.demo.domain.Category;
import com.shoppingmall.demo.domain.Pagination;

@Controller
public class ProductController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	ProductService productservice;
	
	@Autowired
	CategoryService categoryservice;
	
	@Autowired
	@Qualifier("fileConfig")
	private FileConfig fileconfig;
	
	@GetMapping("/admin/product")
	public String manageProduct(Model model, 
			@RequestParam(value="page", required=false, defaultValue="1") int page) {
		int count = 0;
		Pagination pagination = new Pagination();
		
		count = productservice.countProduct();
		
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.build();
		
		List<Product> pList = productservice.selectProductList(pagination);
		model.addAttribute("pList", pList);
		model.addAttribute("pagination", pagination);
		
		return "/adminProduct";
	}
	
	@GetMapping("/productList")
	public String loadProductList(@RequestParam(value="page", defaultValue="1") int page,
								Model model) {
		int count = 0;
		Pagination pagination = new Pagination();
		
		count = productservice.countProduct();
		
		pagination.setPage(page);
		pagination.setCount(count);
		pagination.build();
		
		List<Product> pList = productservice.selectProductList(pagination);
		productservice.updateProductCategoryPath();
		
		model.addAttribute("pList", pList);
		model.addAttribute("pagination", pagination);
		
		return "/productList";
	}
	
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/insertProduct")
	public String insertProductForm(Model model) {
		List<Category> tierCategory = categoryservice.selectTierCategory();
	    
	    model.addAttribute("tierCategory", tierCategory);
		
		return "/insert_product";
	}
	
	@Secured({"ROLE_ADMIN"})
	@PostMapping("/admin/insertProduct")
	public String insertProduct(@ModelAttribute Product product, 
								@RequestParam("productImage") MultipartFile file) {
		// 1. 파일이 존재하는지 확인
		if (!file.isEmpty()) {
			try {
				// 2. 파일 저장 경로 설정
				String projectPath = System.getProperty("user.dir");
				String uploadPath = projectPath + "/src/main/resources/static/upload/product";
				
				// 3. 업로드 디렉토리 존재 확인 및 생성
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}
				
				// 4. 파일명 중복 방지를 위한 고유 파일명 생성
				String originalFilename = file.getOriginalFilename();
				String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;
				
				// 5. 파일 저장
				File destFile = new File(uploadDir, uniqueFilename);
				file.transferTo(destFile);
				
				// 6. 웹에서 접근 가능한 경로를 상품 객체에 설정
				product.setpImgpath("/upload/product/" + uniqueFilename);
				
				 // 7. 디버깅을 위한 로그 출력
				logger.info("File uploaded to: " + destFile.getAbsolutePath());
				logger.info("Image path set to: " + product.getpImgpath());
				
			// 8. 에러 처리
			} catch (IOException e) {
				logger.error("File upload error: ", e);
				e.printStackTrace();
			}
		}
		
		productservice.updateProductCategoryPath();
		productservice.insertProduct(product);
		return "redirect:/admin/product";
	}
	
	@Secured({"ROLE_ADMIN"})
	@PostMapping("/admin/deleteProduct")
	public String deleteProduct(@RequestParam("pIds") List<Integer> pIds) {
		for(int pId : pIds) {
			productservice.deleteProduct(pId);
		}
		
		return "redirect:/admin/product";
	}
	
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/admin/editProduct")
	public String editProduct(@RequestParam("pId") int pId, Model model) {
		Product product = productservice.selectProductPid(pId);
		List<Category> tierCategory = categoryservice.selectTierCategory();
	    
	    model.addAttribute("tierCategory", tierCategory);
		model.addAttribute("product", product);
		return "/edit_product";
	}
	
	@Secured({"ROLE_ADMIN"})
	@PostMapping("/admin/updateProduct")
	public String updateProduct(
	    @ModelAttribute Product product,  // 폼에서 전송된 상품 정보를 Product 객체로 바인딩
	    @RequestParam(value = "productImage", required = false) MultipartFile file,  // 이미지 파일은 선택사항
		@RequestParam(value = "currentImagePath", required = false) String currentImagePath
	) {
	    // 새로운 이미지가 업로드된 경우에만 처리
	    if (file != null && !file.isEmpty()) {
	        try {
	            // 1. 기존 이미지 파일이 있다면 삭제
	            if (currentImagePath != null) {
	                String projectPath = System.getProperty("user.dir");  // 현재 프로젝트 경로
	                String oldFilePath = projectPath + "/src/main/resources/static" + currentImagePath;  // 기존 이미지의 전체 경로
	                File oldFile = new File(oldFilePath);
	                if (oldFile.exists()) {  // 파일이 실제로 존재하는 경우
	                    oldFile.delete();    // 기존 파일 삭제
	                }
	            }

	            // 2. 새 이미지 저장 준비
	            String projectPath = System.getProperty("user.dir");
	            String uploadPath = projectPath + "/src/main/resources/static/upload/product";  // 새 이미지가 저장될 경로
	            
	            // 3. 업로드 디렉토리 존재 확인 및 생성
	            File uploadDir = new File(uploadPath);
	            if (!uploadDir.exists()) {
	                uploadDir.mkdirs();  // 경로가 없으면 모든 필요한 디렉토리 생성
	            }
	            
	            // 4. 파일명 중복 방지를 위한 고유 파일명 생성
	            String originalFilename = file.getOriginalFilename();  // 원본 파일명
	            String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;  // UUID를 사용한 고유 파일명
	            
	            // 5. 새 이미지 파일 저장
	            File destFile = new File(uploadDir, uniqueFilename);  // 저장될 파일 객체 생성
	            file.transferTo(destFile);  // 실제 파일 저장
	            
	            // 6. 웹에서 접근 가능한 경로를 상품 객체에 설정
	            product.setpImgpath("/upload/product/" + uniqueFilename);
	            
	            // 7. 디버깅을 위한 로그 출력
	            logger.info("New file uploaded to: " + destFile.getAbsolutePath());  // 실제 저장 경로
	            logger.info("New image path set to: " + product.getpImgpath());      // DB에 저장될 경로
	            
	        } catch (IOException e) {
	            // 8. 파일 처리 중 발생한 에러 처리
	            logger.error("File upload error: ", e);
	            e.printStackTrace();
	        }
	    } else {
	        product.setpImgpath(currentImagePath);
	    }
	    
	    // 9. 상품 정보 업데이트 (이미지 경로 포함)
	    productservice.updateProduct(product);
	    productservice.updateProductCategoryPath();
	    return "redirect:/admin/product";  // 상품 목록 페이지로 리다이렉트
	}
	
	@GetMapping("/productDetail")
	public String productDetail(@RequestParam("pId") int pId, Model model) {
		// pId에 해당하는 상품 정보 조회
		Product product = productservice.selectProductPid(pId);
		
		// 상품 정보 모델에 추가
		model.addAttribute("product", product);
		
		// 상세 페이지로 이동
		return "/productDetail";
	}

	// 상품 리스트만 로드
	@GetMapping("/homeProductList")
	public String homeProductList(Model model) {
		List<Product> pList = productservice.getAllProducts();
		model.addAttribute("pList", pList);
		return "/homeProductList";
	}
	
	@GetMapping("/homeUI")
	public String homeUI(Model model) {
		List<Category> cList = categoryservice.selectTierCategory();
		model.addAttribute("cList", cList);
		return "/homeUI";
	}
	
	// 카테고리별 상품 연결
	@GetMapping("/userProduct/{cateId}")
	public String userProduct(@PathVariable("cateId") int cateId, Model model) {
		// 카테고리 목록은 selectTierCategory()로 변경 (계층구조 유지를 위해)
		List<Category> cList = categoryservice.selectTierCategory();
		model.addAttribute("cList", cList);
		
		// 해당 카테고리의 상품 목록 조회
		List<Product> pList = productservice.selectProductByCategory(cateId);
		model.addAttribute("pList", pList);
		
		logger.info("카테고리 ID: " + cateId);
		logger.info("상품 목록 크기: " + (pList != null ? pList.size() : "null"));
		
		return "/userProduct";  // 슬래시 제거
	}
}
