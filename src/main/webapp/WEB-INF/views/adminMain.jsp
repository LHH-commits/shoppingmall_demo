<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="adminUI.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 관리자 메인</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
.dashboard-card {
    transition: transform 0.2s;
}
.dashboard-card:hover {
    transform: translateY(-5px);
}
</style>
</head>
<body>
    <div class="container mt-4">
        <!-- 상단 요약 정보 카드 -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="card bg-primary text-white dashboard-card">
                    <div class="card-body">
                        <h5 class="card-title">오늘의 주문</h5>
                        <h3 class="card-text"><fmt:formatNumber value="${todayOrders}" pattern="#,###"/>건</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white dashboard-card">
                    <div class="card-body">
                        <h5 class="card-title">오늘의 매출</h5>
                        <h3 class="card-text"><fmt:formatNumber value="${todaySales}" pattern="#,###"/>원</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-dark dashboard-card">
                    <div class="card-body">
                        <h5 class="card-title">신규 회원</h5>
                        <h3 class="card-text">${newMembers}명</h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- 차트 및 그래프 영역 -->
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        최근 7일 매출 추이
                    </div>
                    <div class="card-body">
                        <!-- 매출 차트 들어갈 자리 -->
                        <canvas id="salesChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        인기 상품 TOP 5
                    </div>
                    <div class="card-body">
                        <!-- 상품 리스트 -->
                        <ul class="list-group list-group-flush">
                            <c:forEach items="${topProducts}" var="product">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <h6 class="mb-0">${product.pName}</h6>
                                        <small class="text-muted">${product.catePath}</small>
                                    </div>
                                    <span class="badge bg-primary rounded-pill">
                                        <fmt:formatNumber value="${product.odPrice}" pattern="#,###"/>원
                                    </span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- 최근 주문 및 문의 목록 -->
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        최근 주문 내역
                        <a href="/order/admin/order" class="btn btn-sm btn-primary">더보기</a>
                    </div>
                    <div class="card-body">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>주문번호</th>
                                    <th>주문자</th>
                                    <th>주문금액</th>
                                    <th>주문상태</th>
                                    <th>주문일시</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentOrders}" var="order">
                                    <tr>
                                        <td>${order.oId}</td>
                                        <td>${order.uName}</td>
                                        <td><fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/>원</td>
                                        <td>
                                            <span class="badge ${order.odDeliveryStatus eq '배송완료' ? 'bg-success' : 
                                                order.odDeliveryStatus eq '배송중' ? 'bg-primary' : 'bg-warning'}">
                                                ${order.odDeliveryStatus}
                                            </span>
                                        </td>
                                        <td><fmt:formatDate value="${order.oDatetime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        공지사항
                        <a href="/admin/notice" class="btn btn-sm btn-primary">더보기</a>
                    </div>
                    <div class="card-body">
                        <!-- 공지사항 목록 -->
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                    <th>조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${recentNotices}" var="notice">
                                    <tr>
                                        <td>
                                            <a href="/admin/boardDetail?bId=${notice.bId}&type=NOTICE" 
                                               class="text-decoration-none">
                                                ${notice.bTitle}
                                            </a>
                                        </td>
                                        <td>${notice.bWriter}</td>
                                        <td>${notice.bDatetime}</td>
                                        <td>${notice.bViews}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        // 데이터 확인용 로그
        console.log('Raw weekly sales:', '${weeklySales}');
        
        // 서버에서 받은 데이터를 차트 데이터로 변환
        const salesData = JSON.parse('${weeklySales}').map(item => {
            return {
                date: item.date,
                sales: item.sales,
                count: item.count
            };
        });
        
        // 변환된 데이터 확인용 로그
        console.log('Parsed sales data:', salesData);
        
        // 날짜 포맷팅 함수
        function formatDate(dateStr) {
            console.log('Input dateStr:', dateStr);  // 입력값 확인
            const [year, month, day] = dateStr.split('-');
            console.log('Split result:', { year, month, day });  // 분리된 값 확인
            
            // 문자열 연결 연산자를 사용
            const formattedDate = parseInt(month) + "월 " + parseInt(day) + "일";
            console.log('Formatted result:', formattedDate);  // 최종 결과 확인
            
            return formattedDate;
        }
        
        // 최근 7일 매출 추이 차트
        const ctx = document.getElementById('salesChart').getContext('2d');
        
        // 데이터 매핑 결과 확인
        const chartLabels = salesData.map(item => formatDate(item.date));
        console.log('Chart labels:', chartLabels);
        
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: chartLabels,
                datasets: [{
                    label: '일일 매출',
                    data: salesData.map(item => item.sales),
                    borderColor: 'rgb(75, 192, 192)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    fill: true,
                    tension: 0.1,
                    yAxisID: 'y'
                }, {
                    label: '주문 건수',
                    data: salesData.map(item => item.count),
                    borderColor: 'rgb(255, 99, 132)',
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    fill: true,
                    tension: 0.1,
                    yAxisID: 'y1'
                }]
            },
            options: {
                responsive: true,
                interaction: {
                    mode: 'index',
                    intersect: false,
                },
                plugins: {
                    title: {
                        display: true,
                        text: '최근 7일간 매출 및 주문 현황'
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                let label = context.dataset.label || '';
                                if (label) {
                                    label += ': ';
                                }
                                if (context.parsed.y !== null) {
                                    label += context.dataset.label === '일일 매출' 
                                        ? new Intl.NumberFormat('ko-KR').format(context.parsed.y) + '원'
                                        : context.parsed.y + '건';
                                }
                                return label;
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        title: {
                            display: true,
                            text: '매출액 (원)'
                        },
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return new Intl.NumberFormat('ko-KR').format(value) + '원';
                            }
                        }
                    },
                    y1: {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        title: {
                            display: true,
                            text: '주문 건수'
                        },
                        grid: {
                            drawOnChartArea: false
                        },
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1,
                            callback: function(value) {
                                return value + '건';
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>