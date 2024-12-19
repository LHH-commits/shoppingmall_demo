package com.shoppingmall.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingmall.demo.domain.Product;
import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.SearchParam;
import com.shoppingmall.demo.mapper.ProductMapper;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired
	ProductMapper productmapper;
	
	@Override
	public List<Product> selectProductList(Pagination pagination) {
		return productmapper.selectProductList(pagination);
	}
	
	@Override
	public Product selectProductPid(int pId) {
		return productmapper.selectProductPid(pId);
	}
	
	@Override
	public int countProduct() {
		return productmapper.countProduct();
	}
	
	@Override
	public void insertProduct(Product product) {
		productmapper.insertProduct(product);
	}
	
	@Override
	public void deleteProduct(int pId) {
		productmapper.deleteProduct(pId);
	}
	
	@Override
	public void deleteProducts(List<Integer> pIds) {
		productmapper.deleteProducts(pIds);
	}
	
	@Override
	public void updateProduct(Product product) {
		productmapper.updateProduct(product);
	}
	
	@Override
	public List<Product> getAllProducts() {
		return productmapper.getAllProducts();
	}
	
	@Override
	public void updateProductCategoryPath() {
		productmapper.updateProductCategoryPath();
	}
	
	@Override
	public List<Product> selectProductByCategory(Integer cateId) {
		return productmapper.selectProductByCategory(cateId);
	}

	@Override
	public List<Product> searchProducts(SearchParam searchParam) {
		return productmapper.searchProducts(searchParam);
	}
}
