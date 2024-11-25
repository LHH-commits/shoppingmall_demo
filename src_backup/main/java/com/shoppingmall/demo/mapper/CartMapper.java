package com.shoppingmall.demo.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.shoppingmall.demo.domain.Cart;

@Mapper
public interface CartMapper {
	 // 장바구니 목록 조회
    public List<Cart> selectCartList(String uId);
    
    // 장바구니에 상품 추가
    public void addToCart(Cart cart);
    
    // 장바구니 상품 수량 업데이트
    public void updateCartAmount(@Param("cartId") int cartId, 
                         @Param("uId") String uId, 
                         @Param("cartAmount") int cartAmount);
    
    // 장바구니에서 상품 삭제
    public void removeFromCart(@Param("cartId") int cartId, 
                       @Param("uId") String uId);
    
    // 장바구니 비우기
    public void clearCart(String uId);
    
    // 장바구니 상품 개수 조회
    public int cartItemCount(String uId);
    
    // 장바구니 총 금액 계산
    public int cartTotalPrice(String uId);
    
    // 장바구니에 해당 상품이 있는지 확인
    public Cart checkProductInCart(@Param("uId") String uId, 
                          @Param("pId") int pId);
    
    // 장바구니 상품 개별(개수) 업데이트
    public void updateExistAmount(@Param("uId") String uId, 
                         @Param("pId") int pId, 
                         @Param("cartAmount") int cartAmount);
}
