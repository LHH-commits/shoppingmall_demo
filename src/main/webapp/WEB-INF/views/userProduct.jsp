<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="homeUI.jsp" %>    
<!DOCTYPE html>
<html>
<head>
    <title>${currentCategory.cateName} - 쇼핑몰</title>
    <style>
        .category-header {
            background-color: #f8f9fa;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .category-path {
            color: #6c757d;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        .category-title {
            font-size: 2rem;
            font-weight: bold;
            margin: 0;
        }
        .product-name {
            text-decoration: none;
            color: dimgray;
        }
        .product-name:hover {
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="category-header">
        <div class="container">
            <div class="category-path">${categoryPath}</div>
            <h1 class="category-title">${currentCategory.cateName}</h1>
        </div>
    </div>

    <!-- Section-->
    <section class="py-5">
        <div class="container px-4 px-lg-5 mt-5">
            <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
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
                                        <a href="${pageContext.request.contextPath}/productDetail?pId=${product.pId}" 
                                           class="product-name">
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
                                    <button class="btn btn-outline-dark mt-auto" 
                                            onclick="addToCart(${product.pId})">
                                        장바구니 추가
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
    
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
