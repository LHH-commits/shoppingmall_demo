<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="homeUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>제품 상세페이지</title>
    <style>
        .product-detail {
            display: flex;
            justify-content: between;
            align-items: start;
            margin-top: 20px;
            padding-left: 40px;
        }
        .thumbnail {
            width: 450px; /* 썸네일 이미지 크기 조정 */
            height: auto;
        }
        .details {
            margin-left: 30px; /* 썸네일과의 간격 */
        }
        .product-description {
	        margin-top: 20px;
	        line-height: 1.6;
	        /* 필요한 경우 추가 스타일링 */
    	}
    </style>
</head>
<body>
    <div class="container mt-5" style="margin-left: 400px">
        <h2 class="mb-4">제품 상세</h2>
        <div class="product-detail">
            <div>
            	
                <img class="thumbnail me-5" src="${pageContext.request.contextPath}${product.pImgpath}" alt="${product.pName}">
            </div>
            <div class="details">
            	<h6>${product.catePath}</h6>
                <h3 style="margin-bottom: 110px; margin-top:100px"><strong>${product.pName}</strong></h3><!-- 상품명 -->
                <h5 style="margin-bottom: 90px;""><strong>판매가</strong> ${product.pPrice} 원</h5> <!-- 가격 -->
                <h6 style="margin-bottom: 10px"><strong>판매자</strong> ${product.pSeller}</h6>
                
                <div class="mb-3">
                    <label for="amount" class="form-label">수량</label>
                    <div class="input-group" style="width: 150px;">
                        <button class="btn btn-outline-secondary" type="button" onclick="decreaseAmount()">-</button>
                        <input type="text" id="amount" class="form-control text-center" value="1" readonly>
                        <button class="btn btn-outline-secondary" type="button" onclick="increaseAmount()">+</button>
                    </div>
                </div>
                
                <button class="btn btn-outline-dark btn-lg" onclick="addToCart('${product.pId}')">장바구니 추가</button>
                <button class="btn btn-primary btn-lg" onclick="directCheckout(${product.pId})">결제하기</button>
            </div>
        </div>
        <div class="product-description p-4">
            <h4>상세 설명</h4>
            <div class="mt-4 ms-3">${product.pDetail}</div> <!-- p_detail 내용 -->
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
    </script>
</body>
</html>