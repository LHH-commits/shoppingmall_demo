package com.shoppingmall.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
    public Orders selectOrderById(String oId) {
        return ordermapper.selectOrderById(oId);
    }

    @Override
    public List<OrderDetail> selectOrderDetailsByOrderId(String oId) {
        return ordermapper.selectOrderDetailsByOrderId(oId);
    }

    @Override
    public List<Orders> selectOrdersByUId(String uId) {
        return ordermapper.selectOrdersByUId(uId);
    }

    @Override
    public void updateOrder(Orders order) {
        ordermapper.updateOrder(order);
    }

    @Override
    public void deleteOrder(String oId) {
        ordermapper.deleteOrder(oId);
    }

    @Override
    public void deleteOrderDetail(String oId) {
        ordermapper.deleteOrderDetail(oId);
    }

    @Override
    public Orders getLatestOrder(String uId) {
        return ordermapper.getLatestOrder(uId);
    }

    @Override
    public String getOrderId(Orders order) {
        return ordermapper.getOrderId(order);
    }

    @Override
    public List<OrderDetail> selectOrdersWithDetailsByUId(String uId) {
        return ordermapper.selectOrdersWithDetailsByUId(uId);
    }

    @Override
    public List<OrderDetail> getOrderList(Map<String, Object> params) {
        return ordermapper.getOrderList(params);
    }

    @Override
    public int getOrderCount() {
        return ordermapper.getOrderCount();
    }

    @Override
    public void updateOrderStatus(OrderDetail orderDetail) {
        ordermapper.updateOrderStatus(orderDetail);
    }
}
