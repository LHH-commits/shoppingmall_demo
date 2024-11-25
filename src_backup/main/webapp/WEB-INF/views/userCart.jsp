<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="homeUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 페이지</title>
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">장바구니</h2>
        
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>상품명</th>
                        <th>가격</th>
                        <th>수량</th>
                        <th>총 가격</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cartItems}" var="item">
                        <tr>
                            <td>${item.product.pName}</td>
                            <td><fmt:formatNumber value="${item.product.pPrice}" pattern="#,###"/>원</td>
                            <td>
                                <div class="input-group" style="width: 150px;">
                                    <button class="btn btn-outline-secondary" onclick="updateAmount('${item.cartId}', -1)">-</button>
                                    <input type="text" class="form-control text-center" value="${item.cartAmount}" readonly>
                                    <button class="btn btn-outline-secondary" onclick="updateAmount('${item.cartId}', 1)">+</button>
                                </div>
                            </td>
                            <td><fmt:formatNumber value="${item.product.pPrice * item.cartAmount}" pattern="#,###"/>원</td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="removeItem('${item.cartId}')">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3" class="text-end"><strong>총계:</strong></td>
                        <td><strong><fmt:formatNumber value="${cartTotalPrice}" pattern="#,###"/>원</strong></td>
                        <td>
                            <div class="d-flex gap-2">
                                <button class="btn btn-warning" onclick="clearCart()">전체 비우기</button>
                                <c:if test="${not empty cartItems}">
                                    <button class="btn btn-primary" onclick="proceedToCheckout()">결제하기</button>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>

    <script>
    function updateAmount(cartId, change) {
        const inputElement = event.target.parentElement.querySelector('input');
        let newAmount = parseInt(inputElement.value) + change;
        if (newAmount < 1) return;

        $.ajax({
            url: '/cart/update',
            type: 'POST',
            data: {
                cartId: cartId,
                amount: newAmount
            },
            success: function(response) {
                location.reload();
            },
            error: function(xhr) {
                alert(xhr.responseText);
            }
        });
    }

    function removeItem(cartId) {
        if (!confirm('이 상품을 삭제하시겠습니까?')) return;
        
        $.ajax({
            url: '/cart/remove',
            type: 'POST',
            data: { cartId: cartId },
            success: function(response) {
                location.reload();
            },
            error: function(xhr) {
                alert(xhr.responseText);
            }
        });
    }

    function clearCart() {
        if (!confirm('장바구니를 비우시겠습니까?')) return;
        
        $.ajax({
            url: '/cart/clear',
            type: 'POST',
            success: function(response) {
                location.reload();
            },
            error: function(xhr) {
                alert(xhr.responseText);
            }
        });
    }

    function proceedToCheckout() {
        window.location.href = '/order/checkout';
    }
    </script>
</body>
</html>