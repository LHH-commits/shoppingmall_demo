<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminUI.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 관리자 메인</title>
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
                        <h3 class="card-text">건</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-success text-white dashboard-card">
                    <div class="card-body">
                        <h5 class="card-title">오늘의 매출</h5>
                        <h3 class="card-text">원</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-warning text-dark dashboard-card">
                    <div class="card-body">
                        <h5 class="card-title">신규 회원</h5>
                        <h3 class="card-text">명</h3>
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
                        <!-- 주문 목록 테이블 -->
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
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>