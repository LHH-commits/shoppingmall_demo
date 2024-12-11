package com.shoppingmall.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.http.ResponseEntity;
import com.shoppingmall.demo.service.ChartService;
import com.shoppingmall.demo.service.CategoryService;
import com.shoppingmall.demo.domain.Category;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class ChartController {
    
    @Autowired
    private ChartService chartservice;
    
    @Autowired
    private CategoryService categoryservice;
    
    // 차트 페이지 이동
    @GetMapping("/chart")
    public String showChartPage(Model model) {
        // 전체 카테고리 목록 조회
        List<Category> tierCategory = categoryservice.selectTierCategory();
        
        // 최상위 카테고리만 필터링
        List<Category> topCategory = tierCategory.stream()
                .filter(c -> c.getParentId() == null)
                .collect(Collectors.toList());
        
        model.addAttribute("topCategory", topCategory);
        return "/adminChart";
    }

    // 기간별 매출 통계
    @PostMapping("/chart/sales")
    public ResponseEntity<List<Map<String, Object>>> getSalesStats(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate) {
        return ResponseEntity.ok(chartservice.getSalesStatsByPeriod(startDate, endDate));
    }

    // 카테고리별 매출 통계
    @PostMapping("/chart/category")
    @ResponseBody
    public List<Map<String, Object>> getSalesStatsByCategory(
        @RequestParam(required = false) String startDate,
        @RequestParam(required = false) String endDate,
        @RequestParam(required = false) Integer categoryId
    ) {
        return chartservice.getSalesStatsByCategory(startDate, endDate, categoryId);
    }

    // 상품별 판매 순위
    @PostMapping("/chart/top-products")
    public ResponseEntity<List<Map<String, Object>>> getTopProducts(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate) {
        return ResponseEntity.ok(chartservice.getTopSellingProducts(startDate, endDate));
    }

    // 일별 평균 주문금액
    @PostMapping("/chart/average-order")
    public ResponseEntity<List<Map<String, Object>>> getAverageOrder(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate) {
        return ResponseEntity.ok(chartservice.getAverageOrderAmount(startDate, endDate));
    }
}

