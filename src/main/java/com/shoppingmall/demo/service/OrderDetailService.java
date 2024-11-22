package com.shoppingmall.demo.service;

import com.shoppingmall.demo.domain.OrderDetail;
import java.util.List;

public interface OrderDetailService {
    // 주문 상세 정보 조회
    public OrderDetail getOrderDetail(int oId);

    // 주문에 대한 모든 상세 정보 조회
    public List<OrderDetail> getOrderDetailList(int oId);

    // 주문 상세 정보 저장
    public void insertOrderDetail(OrderDetail orderDetail);

    // 주문 상세 정보 수정
    public void updateOrderDetail(OrderDetail orderDetail);
}
