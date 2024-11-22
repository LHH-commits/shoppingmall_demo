<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../homeUI.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 내역</title>
    <style>
        .order-list {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }
        .order-card {
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            overflow: hidden;
        }
        .order-header {
            background-color: #f8f9fa;
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
        }
        .order-body {
            padding: 20px;
        }
        .status-badge {
            font-size: 0.9em;
            padding: 5px 10px;
            border-radius: 15px;
        }
        .status-completed {
            background-color: #28a745;
            color: white;
        }
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="order-list">
        <h2 class="mb-4">주문 내역</h2>
        
        <c:forEach items="${orders}" var="order">
            <div class="order-card">
                <div class="order-header d-flex justify-content-between align-items-center">
                    <div>
                        <span class="fw-bold">주문번호: ${order.oId}</span>
                        <span class="ms-3 text-muted">
                            ${order.oDatetime}
                        </span>
                    </div>
                    <span class="status-badge status-completed">결제완료</span>
                </div>
                <div class="order-body">
                    <c:forEach items="${order.orderDetails}" var="detail">
                        <div class="d-flex align-items-center mb-3">
                            <img src="${detail.product.pImgpath}" alt="${detail.product.pName}" 
                                 class="product-image me-3">
                            <div class="flex-grow-1">
                                <h5 class="mb-1">${detail.product.pName}</h5>
                                <p class="mb-1 text-muted">
                                    수량: ${detail.odCount}개
                                </p>
                                <p class="mb-0">
                                    <fmt:formatNumber value="${detail.odPrice}" type="currency" 
                                                    currencySymbol="₩"/>
                                </p>
                            </div>
                        </div>
                    </c:forEach>
                    <hr>
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <p class="mb-0">배송지: ${order.oAddress}</p>
                            <p class="mb-0 text-muted">요청사항: ${order.oInfo}</p>
                        </div>
                        <div class="text-end">
                            <p class="mb-1">총 결제금액</p>
                            <h4 class="mb-0">
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" 
                                                currencySymbol="₩"/>
                            </h4>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty orders}">
            <div class="text-center py-5">
                <h4 class="text-muted">주문 내역이 없습니다</h4>
                <a href="/userHome" class="btn btn-primary mt-3">쇼핑하러 가기</a>
            </div>
        </c:if>
    </div>
</body>
</html>
