package com.shoppingmall.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoppingmall.demo.mapper.DashboardMapper;
import com.shoppingmall.demo.domain.Dashboard;
import java.util.List;
import java.util.Map;

@Service
public class DashboardServiceImpl implements DashboardService {
    
    @Autowired
    private DashboardMapper dashboardmapper;

    @Override
    public int todayOrders() {
        Dashboard result = dashboardmapper.todayOrders();
        return result.getTodayOrders();
    }

    @Override
    public int todaySales() {
        Dashboard result = dashboardmapper.todaySales();
        return result.getTodaySales();
    }

    @Override
    public int newMembers() {
        Dashboard result = dashboardmapper.newMembers();
        return result.getNewMembers();
    }

    @Override
    public List<Map<String, Object>> weeklySales() {
        return dashboardmapper.weeklySales();
    }

    @Override
    public List<Map<String, Object>> topProducts() {
        return dashboardmapper.topProducts();
    }

    @Override
    public List<Map<String, Object>> recentOrders() {
        return dashboardmapper.recentOrders();
    }

    @Override
    public List<Map<String, Object>> recentNotices() {
        return dashboardmapper.recentNotices();
    }
}
