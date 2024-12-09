package com.shoppingmall.demo.service;

import java.util.List;
import java.util.Map;

public interface ChartService {
    List<Map<String, Object>> getSalesStatsByPeriod(String startDate, String endDate);
    
    List<Map<String, Object>> getSalesStatsByCategory(String startDate, String endDate, Integer categoryId);
    
    List<Map<String, Object>> getTopSellingProducts(String startDate, String endDate);
    
    List<Map<String, Object>> getAverageOrderAmount(String startDate, String endDate);
}
