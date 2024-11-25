package com.shoppingmall.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingmall.demo.domain.OrderDetail;
import com.shoppingmall.demo.domain.Orders;
import com.shoppingmall.demo.mapper.OrderMapper;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper ordermapper;

    @Override
    public void insertOrder(Orders order) {
        ordermapper.insertOrder(order);
    }

    @Override
    public void insertOrderDetail(OrderDetail orderDetail) {
        ordermapper.insertOrderDetail(orderDetail);
    }

    @Override
    public Orders selectOrderById(int oId) {
        return ordermapper.selectOrderById(oId);
    }

    @Override
    public List<OrderDetail> selectOrderDetailsByOrderId(int oId) {
        return ordermapper.selectOrderDetailsByOrderId(oId);
    }

    @Override
    public List<Orders> selectOrdersByUId(int uId) {
        return ordermapper.selectOrdersByUId(uId);
    }

    @Override
    public void updateOrder(Orders order) {
        ordermapper.updateOrder(order);
    }

    @Override
    public void deleteOrder(int oId) {
        ordermapper.deleteOrder(oId);
    }

    @Override
    public void deleteOrderDetail(int oId) {
        ordermapper.deleteOrderDetail(oId);
    }

    @Override
    public Orders getLatestOrder(String uId) {
        return ordermapper.getLatestOrder(uId);
    }
}
