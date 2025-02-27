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
                            <td class="align-middle">
                                <!-- 상품 이미지와 이름을 함께 표시 -->
                                <div class="d-flex align-items-center">
                                    <c:choose>
                                        <c:when test="${not empty item.product.pImgpath}">
                                            <img src="${item.product.pImgpath}" 
                                                 alt="${item.product.pName}"
                                                 class="me-3"
                                                 style="width: 50px; height: 50px; object-fit: contain;">
                                        </c:when>
                                        <c:otherwise>
                                            <%-- 기본 이미지 표시 --%>
                                            <img src="${pageContext.request.contextPath}/resources/images/no-image.png" 
                                                 alt="상품 이미지 없음"
                                                 class="me-3"
                                                 style="width: 50px; height: 50px; object-fit: contain;">
                                        </c:otherwise>
                                    </c:choose>
                                    <span>${item.product.pName}</span>
                                </div>
                            </td>
                            <td class="align-middle">
                                <fmt:formatNumber value="${item.product.pPrice}" pattern="#,###"/>원
                            </td>
                            <td class="align-middle">
                                <div class="input-group" style="width: 150px;">
                                    <button class="btn btn-outline-secondary" onclick="updateAmount('${item.cartId}', -1)">-</button>
                                    <input type="text" class="form-control text-center" value="${item.cartAmount}" readonly>
                                    <button class="btn btn-outline-secondary" onclick="updateAmount('${item.cartId}', 1)">+</button>
                                </div>
                            </td>
                            <td class="align-middle">
                                <fmt:formatNumber value="${item.product.pPrice * item.cartAmount}" pattern="#,###"/>원
                            </td>
                            <td class="align-middle">
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