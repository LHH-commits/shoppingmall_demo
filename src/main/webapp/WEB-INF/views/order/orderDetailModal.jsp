<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="order-detail">
    <div class="order-header mb-3">
        <div class="d-flex justify-content-between align-items-center">
            <h6 class="mb-0">주문번호: ${order.oId}</h6>
            <span class="text-muted">
                <fmt:formatDate value="${order.oDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </span>
        </div>
    </div>

    <div class="order-products">
        <c:forEach items="${orderDetails}" var="detail">
            <div class="card mb-3">
                <div class="row g-0">
                    <div class="col-md-2">
                        <img src="${detail.product.pImgpath}" 
                             class="img-fluid rounded-start" 
                             alt="${detail.product.pName}"
                             style="width: 100px; height: 100px; object-fit: cover;">
                    </div>
                    <div class="col-md-10">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <h6 class="card-title">${detail.product.pName}</h6>
                                <span class="badge bg-secondary">${detail.odDeliveryStatus}</span>
                            </div>
                            <p class="card-text">
                                <small class="text-muted">수량: ${detail.odCount}개</small><br>
                                <strong>가격: <fmt:formatNumber value="${detail.odPrice}" pattern="#,###"/>원</strong>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="order-summary mt-4">
        <div class="row">
            <div class="col-md-6">
                <h6>배송 정보</h6>
                <p class="mb-1">주소: ${order.oAddress}</p>
                <p class="mb-1">요청사항: ${order.oInfo}</p>
            </div>
            <div class="col-md-6 text-end">
                <h6>결제 정보</h6>
                <h4 class="text-primary">
                    총 결제금액: <fmt:formatNumber value="${totalAmount}" pattern="#,###"/>원
                </h4>
            </div>
        </div>
    </div>
</div>
