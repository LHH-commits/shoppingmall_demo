<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>쇼핑몰 페이지</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <!-- CSS 추가 -->
        <style>
        .dropdown-submenu {
            position: relative;
        }

        .dropdown-submenu .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -1px;
        }

        .dropend .dropdown-toggle::after {
            float: right;
            margin-top: 8px;
        }

        .dropdown-item:hover {
            background-color: #f8f9fa;
        }
        </style>
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="/userHome">쇼핑몰 프로젝트</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        
                        <!-- 재귀적 카테고리 메뉴 생성 -->
                        <c:forEach var="category" items="${cList}">
                            <c:if test="${empty category.parentId}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" 
                                       id="navbarDropdown${category.cateId}" 
                                       href="#"
                                       role="button" 
                                       data-bs-toggle="dropdown" 
                                       aria-expanded="false">
                                        ${category.cateName}
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown${category.cateId}">
                                        <!-- 1차 분류 메뉴 -->
                                        <li>
                                            <a class="dropdown-item" href="/userProduct/${category.cateId}">
                                                전체 ${category.cateName}
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider" /></li>
                                        
                                        <!-- 2차 분류 메뉴 -->
                                        <c:forEach var="subCategory" items="${cList}">
                                            <c:if test="${subCategory.parentId == category.cateId}">
                                                <li class="dropdown-submenu dropend">
                                                    <a class="dropdown-item ${not empty lastCategory.parentId ? 'dropdown-toggle' : ''}" 
                                                       href="/userProduct/${subCategory.cateId}">
                                                        ${subCategory.cateName}
                                                    </a>
                                                    
                                                    <!-- 3차 분류가 있는 경우에만 하위 메뉴 생성 -->
                                                    <c:set var="hasThirdLevel" value="false" />
                                                    <c:forEach var="lastCategory" items="${cList}">
                                                        <c:if test="${lastCategory.parentId == subCategory.cateId}">
                                                            <c:set var="hasThirdLevel" value="true" />
                                                        </c:if>
                                                    </c:forEach>
                                                    
                                                    <c:if test="${hasThirdLevel}">
                                                        <ul class="dropdown-menu">
                                                            <c:forEach var="lastCategory" items="${cList}">
                                                                <c:if test="${lastCategory.parentId == subCategory.cateId}">
                                                                    <li>
                                                                        <a class="dropdown-item" 
                                                                           href="/userProduct/${lastCategory.cateId}">
                                                                            ${lastCategory.cateName}
                                                                        </a>
                                                                    </li>
                                                                </c:if>
                                                            </c:forEach>
                                                        </ul>
                                                    </c:if>
                                                </li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>
                            </c:if>
                        </c:forEach>

                        <!-- 고객센터 드롭다운은 유지 -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" 
                               data-bs-toggle="dropdown" aria-expanded="false">고객센터</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <!-- <li><a class="dropdown-item" href="#!">고객 서비스</a></li>
                                <li><hr class="dropdown-divider" /></li> -->
                                <li><a class="dropdown-item" href="/userNotice">공지사항</a></li>
                                <li><a class="dropdown-item" href="/userFAQ">자주 묻는 질문(FAQ)</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="d-flex">
                        <a href="/user/cart" class="btn btn-outline-dark me-3">
                            <i class="bi-cart-fill me-1"></i>
                            장바구니
                            <span id="cartCount" class="badge bg-dark text-white ms-1 rounded-pill">0</span>
                        </a>
                        <!-- 인증된 사용자는 로그아웃 버튼이 뜬다 -->
                        <sec:authorize access="isAuthenticated()">
	                        <a href="/logout" class="btn btn-secondary btn-sm me-2">로그아웃</a>
	                        <sec:authorize access="hasRole('ROLE_ADMIN')">
	                            <a href="/admin/main" class="btn btn-outline-info btn-sm">관리자페이지</a>
	                        </sec:authorize>
                        </sec:authorize>
                        <sec:authorize access="isAnonymous()">
                        	<a href="/" class="btn btn-primary btn-sm me-2">로그인</a>
                        </sec:authorize>
                    </form>
                </div>
            </div>
        </nav>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        
        <script>
        // 페이지 로드시 장바구니 개수 업데이트
        $(document).ready(function() {
            updateCartCount();
            // 드롭다운 서브메뉴 동작 설정
            $('.dropdown-submenu > a').on('click', function(e) {
                if ($(this).next('ul').length) {
                    e.preventDefault();
                    $(this).next('ul').toggle();
                }
            });

            // 드롭다운 메뉴 hover 설정
            $('.dropdown-submenu').hover(
                function() {
                    $(this).children('.dropdown-menu').show();
                },
                function() {
                    $(this).children('.dropdown-menu').hide();
                }
            );
        });

        // 장바구니 개수 가져오기
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