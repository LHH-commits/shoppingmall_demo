<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="adminUI.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>매출 통계</title>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Datepicker -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"></script>
    
    <style>
        .chart-container {
            position: relative;
            margin: auto;
            height: 400px;
            width: 100%;
        }
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .table th {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mt-3 mb-3">통계/분석</h2>
        <!-- 필터 섹션 -->
        <div class="filter-section">
            <form id="statsForm">
                <div class="row">
                    <!-- 기간 선택 -->
                    <div class="col-md-6">
                        <div class="d-flex align-items-center mb-2">
                            <label class="form-label mb-0">기간 선택</label>
                            <button type="button" class="btn btn-sm btn-light ms-2" 
                                    onclick="resetDateRange()" style="font-size: 12px;">
                                초기화
                            </button>
                        </div>
                        <div class="input-group">
                            <input type="text" class="form-control datepicker" id="startDate" name="startDate">
                            <span class="input-group-text">~</span>
                            <input type="text" class="form-control datepicker" id="endDate" name="endDate">
                        </div>
                    </div>
                    <!-- 카테고리 선택 -->
                    <div class="col-md-6">
                        <label class="form-label">카테고리 선택</label>
                        <div class="d-flex">
                            <select class="form-select me-2" id="firstCategory" name="parentId">
                                <option value="">=1차 카테고리 선택=</option>
                                <c:forEach var="category" items="${topCategory}">
                                    <option value="${category.cateId}">${category.cateName}</option>
                                </c:forEach>
                            </select>
                            <select class="form-select me-2" id="secondCategory" disabled>
                                <option value="">=2차 카테고리 선택=</option>
                            </select>
                            <select class="form-select" id="thirdCategory" disabled>
                                <option value="">=3차 카테고리 선택=</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-12 text-end">
                        <button type="button" class="btn btn-primary" onclick="updateCharts()">조회</button>
                    </div>
                </div>
            </form>
        </div>

        <!-- 차트 섹션 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="chart-container">
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
            <div class="col-md-6">
                <div class="chart-container">
                    <canvas id="quantityChart"></canvas>
                </div>
            </div>
        </div>

        <!-- 상품 리스트 테이블 -->
        <div class="row">
            <div class="col-12">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col">순위</th>
                            <th scope="col">상품명</th>
                            <th scope="col">카테고리</th>
                            <th scope="col">판매가</th>
                            <th scope="col">판매량</th>
                            <th scope="col">판매총액</th>
                            <th scope="col">평균평점</th>
                        </tr>
                    </thead>
                    <tbody id="productList">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        let salesChart = null;
        let quantityChart = null;

        // 날짜 초기화 함수
        function resetDateRange() {
            $('#startDate').val('');
            $('#endDate').val('');
            updateCharts();  // 차트 업데이트
        }

        $(document).ready(function() {
            // Datepicker 초기화
            $('.datepicker').datepicker({
                format: 'yyyy-mm-dd',
                language: 'ko',
                autoclose: true
            });

            // 초기 차트 생성
            initCharts();
            
            // 카테고리 변경 이벤트 처리
            $('#firstCategory').change(function() {
                const parentId = $(this).val();
                const secondCategory = $('#secondCategory');
                const thirdCategory = $('#thirdCategory');
                
                // 2차, 3차 카테고리 초기화
                secondCategory.html('<option value="">=2차 카테고리 선택=</option>').prop('disabled', true);
                thirdCategory.html('<option value="">=3차 카테고리 선택=</option>').prop('disabled', true);
                
                if (parentId) {
                    // 2차 카테고리 로드
                    $.ajax({
                        url: '/admin/category/sub',
                        type: 'GET',
                        data: { parentId: parentId },
                        dataType: 'json',
                        contentType: 'application/json',
                        success: function(data) {
                            if (data && data.length > 0) {
                                secondCategory.prop('disabled', false);
                                data.forEach(function(category) {
                                    secondCategory.append(
                                        $('<option>', {
                                            value: category.cateId,
                                            text: category.cateName
                                        })
                                    );
                                });
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('2차 카테고리 로드 실패:', error);
                        }
                    });
                }
            });

            // 2차 카테고리 변경 시
            $('#secondCategory').change(function() {
                const parentId = $(this).val();
                const thirdCategory = $('#thirdCategory');
                
                // 3차 카테고리 초기화
                thirdCategory.html('<option value="">=3차 카테고리 선택=</option>').prop('disabled', true);
                
                if (parentId) {
                    // 3차 카테고리 로드
                    $.ajax({
                        url: '/admin/category/sub',
                        type: 'GET',
                        data: { parentId: parentId },
                        dataType: 'json',
                        contentType: 'application/json',
                        success: function(data) {
                            if (data && data.length > 0) {
                                thirdCategory.prop('disabled', false);
                                data.forEach(function(category) {
                                    thirdCategory.append(
                                        $('<option>', {
                                            value: category.cateId,
                                            text: category.cateName
                                        })
                                    );
                                });
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('3차 카테고리 로드 실패:', error);
                        }
                    });
                }
            });
            
            // 초기 데이터 로드 (날짜 없이)
            updateCharts();
        });

        function initCharts() {
            // 매출액 차트 초기화
            const salesCtx = document.getElementById('salesChart').getContext('2d');
            salesChart = new Chart(salesCtx, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [{
                        label: '매출액',
                        data: [],
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                }
            });

            // 판매량 차트 초기화
            const quantityCtx = document.getElementById('quantityChart').getContext('2d');
            quantityChart = new Chart(quantityCtx, {
                type: 'bar',
                data: {
                    labels: [],
                    datasets: [{
                        label: '판매량',
                        data: [],
                        backgroundColor: 'rgb(54, 162, 235)'
                    }]
                }
            });
        }

        // 차트 및 데이터 업데이트
        function updateCharts() {
            const startDate = $('#startDate').val() || null;
            const endDate = $('#endDate').val() || null;
            let categoryId = null;
            
            // 가장 하위에 선택된 카테고리 값을 사용
            if ($('#thirdCategory').val()) {
                categoryId = $('#thirdCategory').val();
            } else if ($('#secondCategory').val()) {
                categoryId = $('#secondCategory').val();
            } else if ($('#firstCategory').val()) {
                categoryId = $('#firstCategory').val();
            }

            console.log('Request parameters:', { startDate, endDate, categoryId });

            $.ajax({
                url: '/admin/chart/category',
                method: 'POST',
                data: {
                    startDate: startDate,
                    endDate: endDate,
                    categoryId: categoryId
                },
                success: function(data) {
                    console.log('Ajax response:', data);
                    updateChartsWithData(data);
                    updateProductList(data);
                },
                error: function(error) {
                    console.error('데이터 조회 실패:', error);
                }
            });
        }

        // 차트 데이터 업데이트
        function updateChartsWithData(data) {
            // 데이터 처리 및 차트 업데이트 로직
            const labels = data.map(item => item.p_name);
            const salesData = data.map(item => item.totalAmount);
            const quantityData = data.map(item => item.totalQuantity);

            // 매출액 차트 업데이트
            salesChart.data.labels = labels;
            salesChart.data.datasets[0].data = salesData;
            salesChart.update();

            // 판매량 차트 업데이트
            quantityChart.data.labels = labels;
            quantityChart.data.datasets[0].data = quantityData;
            quantityChart.update();
        }

        // 상품 리스트 업데이트
        function updateProductList(data) {
            const tbody = $('#productList');
            tbody.empty();
            
            if (!data || data.length === 0) {
                tbody.append('<tr><td colspan="7" class="text-center">데이터가 없습니다.</td></tr>');
                return;
            }

            // 데이터를 먼저 정렬
            data.sort((a, b) => a.rank - b.rank);

            data.forEach((item) => {
                // 문자열 이스케이프 처리
                const name = item.p_name ? item.p_name.replace(/'/g, '&#39;') : '';
                const category = item.category_path ? item.category_path.replace(/'/g, '&#39;') : '';
                
                // 숫자 데이터 처리
                const price = item.p_price ? Number(item.p_price).toLocaleString() + '원' : '0원';
                const quantity = item.totalQuantity ? Number(item.totalQuantity).toLocaleString() : '0';
                const amount = item.totalAmount ? Number(item.totalAmount).toLocaleString() + '원' : '0원';
                const rating = item.avgRating ? Number(item.avgRating).toFixed(1) : '0.0';

                // DOM 요소 생성 방식으로 변경
                const tr = $('<tr>');
                tr.append($('<td>').text(item.rank));
                tr.append($('<td>').text(name));
                tr.append($('<td>').text(category));
                tr.append($('<td>').text(price));
                tr.append($('<td>').text(quantity));
                tr.append($('<td>').text(amount));
                tr.append($('<td>').text(rating));
                
                tbody.append(tr);
            });
        }
    </script>
</body>
</html>

