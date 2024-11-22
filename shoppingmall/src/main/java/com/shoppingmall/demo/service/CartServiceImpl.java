package com.shoppingmall.demo.service;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingmall.demo.domain.Cart;
import com.shoppingmall.demo.mapper.CartMapper;


@Service
public class CartServiceImpl implements CartService {
	@Autowired
	CartMapper cartmapper;
	
	@Override
	 // 장바구니 목록 조회
  public List<Cart> selectCartList(String uId) {
	  return cartmapper.selectCartList(uId);
	}
    
	@Override
    // 장바구니에 상품 추가
    public void addToCart(Cart cart) {
        // 이미 장바구니에 있는 상품인지 확인
        Cart existThing = cartmapper.checkProductInCart(cart.getuId(), cart.getpId());
        
        if (existThing != null) {
            // 이미 존재하는 상품이면 수량만 증가
            int newAmount = existThing.getCartAmount() + 1;
            cartmapper.updateExistAmount(cart.getuId(), cart.getpId(), newAmount);
        } else {
            // 새로운 상품이면 새로 추가
            cartmapper.addToCart(cart);
        }
    }
  @Override
    // 장바구니 상품 수량 업데이트
  public void updateCartAmount(@Param("cartId") int cartId, 
                         @Param("uId") String uId, 
                         @Param("cartAmount") int cartAmount) {
    cartmapper.updateCartAmount(cartId, uId, cartAmount);
  }
    
  @Override
    // 장바구니에서 상품 삭제
  public void removeFromCart(@Param("cartId") int cartId, 
                       @Param("uId") String uId) {
    cartmapper.removeFromCart(cartId, uId);
  }
    
  @Override
    // 장바구니 비우기
  public void clearCart(String uId) {
    cartmapper.clearCart(uId);
  }
    
  @Override
    // 장바구니 상품 개수 조회
  public int cartItemCount(String uId) {
    return cartmapper.cartItemCount(uId);
  }

  @Override
    // 장바구니 총 금액 계산
  public int cartTotalPrice(String uId) {
      return cartmapper.cartTotalPrice(uId);
  }
  
  @Override
    // 장바구니에 해당 상품이 있는지 확인
  public Cart checkProductInCart(@Param("uId") String uId, 
                          @Param("pId") int pId) {
    return cartmapper.checkProductInCart(uId, pId);
  }
  
  @Override
  public void updateExistAmount(@Param("uId") String uId, 
				          @Param("pId") int pId, 
				          @Param("cartAmount") int cartAmount) {
	  cartmapper.updateExistAmount(uId, pId, cartAmount);
  }
}
