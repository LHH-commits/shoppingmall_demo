package com.shoppingmall.demo.service;

import java.util.List;

import com.shoppingmall.demo.domain.OrderDetail;
import com.shoppingmall.demo.domain.Orders;

public interface OrderService {
    // 새로운 주문을 생성하고 orders 테이블에 저장
    public void insertOrder(Orders order);

    // 주문에 대한 상세 정보를 order_detail 테이블에 저장
    public void insertOrderDetail(OrderDetail orderDetail);

    // 주문 번호(o_id)로 해당 주문의 기본 정보를 조회
    public Orders selectOrderById(String oId);

    // 주문 번호(o_id)에 해당하는 모든 주문 상세 정보(상품, 수량, 가격 등) 조회
    public List<OrderDetail> selectOrderDetailsByOrderId(String oId);

    // 특정 사용자(u_id)의 모든 주문 목록을 조회
    public List<Orders> selectOrdersByUId(String uId);

    // 주문 정보(배송지, 요청사항 등) 수정
    public void updateOrder(Orders order);

    // 주문 번호(o_id)에 해당하는 주문을 삭제
    public void deleteOrder(String oId);

    // 주문 번호(o_id)에 해당하는 모든 주문 상세 정보를 삭제
    public void deleteOrderDetail(String oId);

    // 사용자의 최근 주문 정보 조회
    public Orders getLatestOrder(String uId);

    // 주문 번호 조회
    public String getOrderId(Orders order);

    // 사용자별 주문 목록 상세 조회
    public List<OrderDetail> selectOrdersWithDetailsByUId(String uId);
}
