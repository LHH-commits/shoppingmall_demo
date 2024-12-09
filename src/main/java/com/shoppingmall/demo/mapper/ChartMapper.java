package com.shoppingmall.demo.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ChartMapper {
    List<Map<String, Object>> getSalesStatsByPeriod(
        @Param("startDate") String startDate, 
        @Param("endDate") String endDate
    );
    
    List<Map<String, Object>> getSalesStatsByCategory(
        @Param("startDate") String startDate, 
        @Param("endDate") String endDate,
        @Param("categoryId") Integer categoryId
    );
    
    List<Map<String, Object>> getTopSellingProducts(
        @Param("startDate") String startDate, 
        @Param("endDate") String endDate
    );
    
    List<Map<String, Object>> getAverageOrderAmount(
        @Param("startDate") String startDate, 
        @Param("endDate") String endDate
    );
}

