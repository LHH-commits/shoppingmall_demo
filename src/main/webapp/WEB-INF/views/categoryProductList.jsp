<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 디버깅용 -->
<c:if test="${empty pList}">
    <div>해당 카테고리의 상품이 없습니다.</div>
</c:if>

<c:forEach items="${pList}" var="product">
    <div class="col mb-5">
        <div class="card h-100">
            <!-- Product image-->
            <c:choose>
                <c:when test="${not empty product.pImgpath}">
                    <a href="${pageContext.request.contextPath}/productDetail?pId=${product.pId}">
                        <img class="card-img-top" 
                             src="${pageContext.request.contextPath}${product.pImgpath}"
                             alt="${product.pName}" 
                             style="aspect-ratio: 1; object-fit: contain; width: 100%;" />
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/productDetail?pId=${product.pId}">
                        <img class="card-img-top" 
                             src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" 
                             alt="${product.pName}" 
                             style="aspect-ratio: 1; object-fit: contain; width: 100%;" />
                    </a>
                </c:otherwise>
            </c:choose>
            <!-- Product details-->
            <div class="card-body p-4">
                <div class="text-center">
                    <!-- Product name-->
                    <h5 class="fw-bolder">
                        <a href="${pageContext.request.contextPath}/productDetail?pId=${product.pId}">
                            ${product.pName}
                        </a>
                    </h5>
                    <!-- Product price-->
                    <span>${product.pPrice}원</span>
                </div>
            </div>
            <!-- Product actions-->
            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                <div class="text-center">
                    <button class="btn btn-outline-dark mt-auto" onclick="addToCart(${product.pId})">
                        장바구니 추가
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

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