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
    	/* 탭 스타일 추가 */
        .board-tabs {
            margin-bottom: 30px;
            border-bottom: 2px solid #eee;
        }
        .board-tabs .tab-link {
            display: inline-block;
            padding: 10px 20px;
            color: #666;
            text-decoration: none;
            margin-right: 20px;
            position: relative;
        }
        .board-tabs .tab-link.active {
            color: #333;
            font-weight: 500;
        }
        .board-tabs .tab-link.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #333;
        }
        .board-tabs .tab-link:hover {
                color: #333;
        }
    </style>
</head>
<body>
    <div class="container mt-5" style="margin-left: 400px">
        <div class="product-detail">
            <div>
            	
                <img class="thumbnail me-5" src="${pageContext.request.contextPath}${product.pImgpath}" alt="${product.pName}">
            </div>
            <div class="details">
            	<h6>${product.catePath}</h6>
                <h3 style="margin-bottom: 110px; margin-top:100px"><strong>${product.pName}</strong></h3><!-- 상품명 -->
                <h5 style="margin-bottom: 90px;""><strong>판매가</strong> ${product.pPrice} 원</h5> <!-- 가격 -->
                <h6 style="margin-bottom: 10px"><strong>판매자</strong> ${product.pSeller}</h6>
                <button class="btn btn-outline-dark btn-lg" onclick="addToCart('${product.pId}')">장바구니 추가</button>
                <button class="btn btn-primary btn-lg">결제하기</button>
            </div>
        </div>
        <div class="product-description p-4">
            <div class="board-tabs">
            	<a href="/productDetail" class="tab-link active">제품상세</a>
		        <a href="/userNotice" class="tab-link">공지사항</a>
		        <a href="/userFAQ" class="tab-link">자주 묻는 질문</a>
		    </div>
            <div id="tabContent" class="mt-4 ms-3">
			    <!-- 탭별 내용이 여기에 동적으로 로드됩니다 -->
			    ${product.pDetail} <!-- 초기에는 제품 상세 내용을 보여줌 -->
			</div>
        </div>
    </div>

    <script>
        function addToCart(productId) {
            $.ajax({
                url: '/addCart',
                type: 'POST', 
                data: { pId: productId },
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
    </script>
</body>
</html>