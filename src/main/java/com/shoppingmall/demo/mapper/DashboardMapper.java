package com.shoppingmall.demo.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.shoppingmall.demo.domain.Dashboard;
import java.util.List;
import java.util.Map;

@Mapper
public interface DashboardMapper {
    
    // 오늘 주문 수
    public Dashboard todayOrders();

    // 오늘 매출
    public Dashboard todaySales();
    
    // 오늘 가입 회원 수
    public Dashboard newMembers();
    
    // 최근 일주일 매출 추이
    public List<Map<String, Object>> weeklySales();
    
    // 인기 상품 TOP 5
    public List<Map<String, Object>> topProducts();
    
    // 최근 주문 내역
    public List<Map<String, Object>> recentOrders();
    
    // 최근 공지사항 목록
    public List<Map<String, Object>> recentNotices();
}
