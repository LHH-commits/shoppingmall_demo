<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../homeUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>주문서 작성</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">주문서 작성</h2>
        
        <!-- 주문 상품 목록 -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">주문 상품 정보</h5>
            </div>
            <div class="card-body">
                <table class="table">
                    <thead>
                        <tr>
                            <th>상품명</th>
                            <th>수량</th>
                            <th>가격</th>
                            <th>총 금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${cartItems}" var="item">
                            <tr>
                                <td>${item.product.pName}</td>
                                <td>${item.cartAmount}</td>
                                <td><fmt:formatNumber value="${item.product.pPrice}" pattern="#,###"/>원</td>
                                <td><fmt:formatNumber value="${item.product.pPrice * item.cartAmount}" pattern="#,###"/>원</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" class="text-end"><strong>총 주문금액:</strong></td>
                            <td><strong><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</strong></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>

        <!-- 배송 정보 입력 폼 -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0">배송 정보</h5>
            </div>
            <div class="card-body">
                <form id="orderForm">
                	<input type="hidden" name="uId" value="${user.uId}">
                    <div class="mb-3">
                        <label for="uName" class="form-label">수령인</label>
                        <input type="text" class="form-control" id="uName" name="uName" value="${user.uName}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="uPhone" class="form-label">연락처</label>
                        <input type="text" class="form-control" id="uPhone" name="uPhone" value="${user.uPhone}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="oAddress" class="form-label">배송주소</label>
                        <input type="text" class="form-control" id="oAddress" name="oAddress" value="${user.uAddress}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="oInfo" class="form-label">배송 요청사항</label>
                        <textarea class="form-control" id="oInfo" name="oInfo" rows="3"></textarea>
                    </div>
                    
                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">주문하기</button>
                        <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
    document.getElementById('orderForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        
        if (confirm('주문을 진행하시겠습니까?')) {
            const orderData = {
                uId: "${user.uId}",
                oAddress: document.getElementById('oAddress').value,
                oInfo: document.getElementById('oInfo').value,
                totalPrice: ${totalPrice}
            };

            try {
                const response = await fetch('/order/place', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(orderData)
                });

                if (response.ok) {
                    const order = await response.json();
                    
                    console.log('Order ID: ', order.oId);
                    window.location.href = `/payment/checkout?orderId=${order.oId}`;
                } else {
                    alert('주문 생성에 실패했습니다.');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('주문 처리 중 오류가 발생했습니다.');
            }
        }
    });
    </script>
</body>
</html>