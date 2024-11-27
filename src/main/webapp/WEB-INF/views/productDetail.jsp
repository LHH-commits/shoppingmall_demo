<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="homeUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품 상세페이지</title>
    <style>
        .product-detail {
            display: flex;
            justify-content: flex-start;
            align-items: flex-start;
            margin-top: 20px;
            padding-left: 40px;
            gap: 50px;
        }
        .thumbnail {
            width: 450px;
            height: 450px;
            object-fit: contain;
        }
        .details {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 450px;
            padding: 20px 0;
        }
        .product-info {
            margin-bottom: auto;
        }
        .product-actions {
            margin-top: auto;
        }
        .product-description {
	        margin-top: 20px;
	        line-height: 1.6;
	        /* 필요한 경우 추가 스타일링 */
    	}
        .reviews-section {
            max-width: 800px;
            margin-top: 50px;
            border-top: 1px solid #dee2e6;
            padding: 30px;
        }
        .review-item {
            border-bottom: 1px solid #eee;
            padding: 20px 0;
        }
        .review-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .star-score {
            color: #ffd700;
        }
        .review-content {
            color: #333;
            line-height: 1.6;
        }
        .review-summary {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .average-score-box {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 30px;
            padding: 10px;
        }
        .score-info {
            text-align: center;
            min-width: 150px;
        }
        .current-score {
            font-size: 24px;
            font-weight: bold;
        }
        .score-number {
            color: #007bff;
            font-size: 32px;
        }
        .total-score {
            color: #6c757d;
        }
        .star-display {
            color: #ffd700;
            font-size: 20px;
            margin-top: 5px;
        }
        .review-count {
            color: #6c757d;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container mt-5" style="margin-left: 400px">
        <h2 class="mb-4">제품 상세</h2>
        <div class="product-detail">
            <div>
                <img class="thumbnail" src="${pageContext.request.contextPath}${product.pImgpath}" alt="${product.pName}">
            </div>
            <div class="details">
                <div class="product-info">
                    <h6>${product.catePath}</h6>
                    <h3 class="mb-4"><strong>${product.pName}</strong></h3>
                    <h5 class="mb-4"><strong>판매가</strong> ${product.pPrice} 원</h5>
                    <h6 class="mb-3"><strong>판매자</strong> ${product.pSeller}</h6>
                </div>
                
                <div class="product-actions">
                    <div class="mb-3">
                        <label for="amount" class="form-label">수량</label>
                        <div class="input-group" style="width: 150px;">
                            <button class="btn btn-outline-secondary" type="button" onclick="decreaseAmount()">-</button>
                            <input type="text" id="amount" class="form-control text-center" value="1" readonly>
                            <button class="btn btn-outline-secondary" type="button" onclick="increaseAmount()">+</button>
                        </div>
                    </div>
                    
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-dark btn-lg" onclick="addToCart('${product.pId}')">장바구니 추가</button>
                        <button class="btn btn-primary btn-lg" onclick="directCheckout(${product.pId})">바로 구매</button>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="product-description p-4">
            <h4>상세 설명</h4>
            <div class="mt-4 ms-3">${product.pDetail}</div>
        </div>

        <div class="reviews-section">
            <h4 class="mb-4">상품평</h4>
            <div class="review-summary">
                <div class="average-score-box">
                    <div class="score-info">
                        <div class="current-score">
                            <span class="score-number">${averageScore}</span>
                            <span class="total-score">/5.0</span>
                        </div>
                        <div class="star-display">
                            ${'★'.repeat(Math.round(Double.parseDouble(averageScore)))}${'☆'.repeat(5-Math.round(Double.parseDouble(averageScore)))}
                        </div>
                    </div>
                    <div class="review-count">
                        전체 리뷰 <strong>${reviewCount}</strong>개
                    </div>
                </div>
            </div>

            <div class="review-list">
                <c:forEach items="${reviews}" var="review">
                    <div class="review-item">
                        <div class="review-header">
                            <div>
                                <span class="fw-bold">${review.rWriter}</span>
                                <span class="text-muted ms-2">
                                    <fmt:formatDate value="${review.rDatetime}" pattern="yyyy-MM-dd HH:mm"/>
                                </span>
                            </div>
                            <div class="star-score">
                                ${'★'.repeat(review.rScore)}${'☆'.repeat(5-review.rScore)}
                                <span class="text-muted">(${review.rScore}점)</span>
                            </div>
                        </div>
                        <div class="review-content">
                            ${review.rContent}
                        </div>
                    </div>
                </c:forEach>
                
                <c:if test="${empty reviews}">
                    <div class="text-center text-muted py-5">
                        <p>아직 작성된 상품평이 없습니다.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        function addToCart(productId) {
            const amount = document.getElementById('amount').value;  // 선택된 수량 가져오기
            
            $.ajax({
                url: '/addCart',
                type: 'POST', 
                data: { 
                    pId: productId,
                    cartAmount: amount  // 선택된 수량 전달
                },
                success: function(response) {
                    alert(response);
                    updateCartCount();
                },
                error: function(xhr, status, error) {
                    alert(xhr.responseText);
                }
            });
        }

        function updateCartCount() {
            $.ajax({
                url: '/cart/count',
                type: 'GET',
                success: function(count) {
                    $('#cartCount').text(count);
                }
            });
        }

        function increaseAmount() {
            const amountInput = document.getElementById('amount');
            let currentAmount = parseInt(amountInput.value);
            amountInput.value = currentAmount + 1;
        }

        function decreaseAmount() {
            const amountInput = document.getElementById('amount');
            let currentAmount = parseInt(amountInput.value);
            if (currentAmount > 1) {
                amountInput.value = currentAmount - 1;
            }
        }

        function directCheckout(productId) {
            const amount = document.getElementById('amount').value;
            
            $.ajax({
                url: '/order/direct-checkout',
                type: 'POST',
                data: { 
                    pId: productId,
                    amount: amount
                },
                success: function(response) {
                    window.location.href = '/order/checkout';
                },
                error: function(xhr) {
                    alert('주문 처리 중 오류가 발생했습니다.');
                }
            });
        }

        document.addEventListener('DOMContentLoaded', function() {
            loadReviews();
        });

        function loadReviews() {
            fetch('/review/list/${product.pId}')
                .then(response => response.json())
                .then(data => {
                    displayReviews(data);
                })
                .catch(error => console.error('Error:', error));
        }

        function displayReviews(reviews) {
            const reviewList = document.getElementById('reviewList');
            const averageScore = document.getElementById('averageScore');
            const reviewCount = document.getElementById('reviewCount');
            
            if (reviews.length > 0) {
                const avg = reviews.reduce((sum, review) => sum + review.rScore, 0) / reviews.length;
                averageScore.textContent = avg.toFixed(1);
                reviewCount.textContent = reviews.length;
            }

            reviewList.innerHTML = reviews.map(review => `
                <div class="review-item">
                    <div class="review-header">
                        <div>
                            <span class="fw-bold">${review.rWriter}</span>
                            <span class="text-muted ms-2">
                                <fmt:formatDate value="${review.rDatetime}" 
                                              pattern="yyyy-MM-dd HH:mm"/>
                            </span>
                        </div>
                        <div class="star-score">
                            ${'★'.repeat(review.rScore)}${'★'.repeat(5-review.rScore)}
                            <span class="text-muted">(${review.rScore}점)</span>
                        </div>
                    </div>
                    <div class="review-content">
                        ${review.rContent}
                    </div>
                </div>
            `).join('');

            if (reviews.length === 0) {
                reviewList.innerHTML = `
                    <div class="text-center text-muted py-5">
                        <p>아직 작성된 상품평이 없습니다.</p>
                    </div>
                `;
            }
        }

        function formatDate(dateString) {
            const date = new Date(dateString);
            return date.toLocaleDateString('ko-KR', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit'
            });
        }
    </script>
</body>
</html>