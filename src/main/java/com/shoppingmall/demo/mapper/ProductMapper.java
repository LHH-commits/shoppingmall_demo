package com.shoppingmall.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.shoppingmall.demo.domain.Product;
import com.shoppingmall.demo.domain.Pagination;
import com.shoppingmall.demo.domain.SearchParam;
@Mapper
public interface ProductMapper {
	public List<Product> selectProductList(Pagination pagination);

	public List<Product> getAllProducts();
	
	public Product selectProductPid(int pId);
	
	public int countProduct();
	
	public void insertProduct(Product product);
	
	public void deleteProduct(int pId);
	
	public void deleteProducts(List<Integer> pIds);
	
	public void updateProduct(Product product);
	
	public void updateProductCategoryPath();
	
	public List<Product> selectProductByCategory(Integer cateId);

	public List<Product> searchProducts(SearchParam searchParam);
}
