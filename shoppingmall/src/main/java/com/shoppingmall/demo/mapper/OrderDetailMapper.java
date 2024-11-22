package com.shoppingmall.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.shoppingmall.demo.domain.OrderDetail;

@Mapper
public interface OrderDetailMapper {
    // 주문 상세 정보 조회
    public OrderDetail getOrderDetail(String oId);
    
    // 주문에 대한 모든 상세 정보 조회
    public List<OrderDetail> getOrderDetailList(String oId);
    
    // 주문 상세 정보 저장
    public void insertOrderDetail(OrderDetail orderDetail);
    
    // 주문 상세 정보 수정
    public void updateOrderDetail(OrderDetail orderDetail);
}
