package com.shoppingmall.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import com.shoppingmall.demo.domain.OrderDetail;
import com.shoppingmall.demo.mapper.OrderDetailMapper;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {
    @Autowired
    private OrderDetailMapper orderDetailmapper;

    @Override
    public OrderDetail getOrderDetail(int oId) {
        return orderDetailmapper.getOrderDetail(oId);
    }

    @Override
    public List<OrderDetail> getOrderDetailList(int oId) {
        return orderDetailmapper.getOrderDetailList(oId);
    }

    @Override
    public void insertOrderDetail(OrderDetail orderDetail) {
        orderDetailmapper.insertOrderDetail(orderDetail);
    }

    @Override
    public void updateOrderDetail(OrderDetail orderDetail) {
        orderDetailmapper.updateOrderDetail(orderDetail);
    }
}
