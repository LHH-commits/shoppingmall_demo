package com.shoppingmall.demo.service;

import java.util.List;

import com.shoppingmall.demo.domain.Product;
import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.SearchParam;

public interface ProductService {
	public List<Product> selectProductList(Pagination pagination);
	
	public Product selectProductPid(int pId);
	
	public int countProduct();
	
	public void insertProduct(Product product);
	
	public void deleteProduct(int pId);
	
	public void deleteProducts(List<Integer> pIds);
	
	public void updateProduct(Product product);
	
	public List<Product> getAllProducts();
	
	public void updateProductCategoryPath();
	
	public List<Product> selectProductByCategory(Integer cateId);

	public List<Product> searchProducts(SearchParam searchParam);
}
