package com.shoppingmall.demo.service;

import com.shoppingmall.demo.mapper.ChartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

@Service
public class ChartServiceImpl implements ChartService {
    
    @Autowired
    private ChartMapper chartmapper;
    
    @Override
    public List<Map<String, Object>> getSalesStatsByPeriod(String startDate, String endDate) {
        return chartmapper.getSalesStatsByPeriod(startDate, endDate);
    }
    
    @Override
    public List<Map<String, Object>> getSalesStatsByCategory(String startDate, String endDate, Integer categoryId) {
        return chartmapper.getSalesStatsByCategory(startDate, endDate, categoryId);
    }
    
    @Override
    public List<Map<String, Object>> getTopSellingProducts(String startDate, String endDate) {
        return chartmapper.getTopSellingProducts(startDate, endDate);
    }
    
    @Override
    public List<Map<String, Object>> getAverageOrderAmount(String startDate, String endDate) {
        return chartmapper.getAverageOrderAmount(startDate, endDate);
    }
}
