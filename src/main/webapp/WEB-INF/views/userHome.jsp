<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="homeUI.jsp" %>    
<!DOCTYPE html>
<html>
    <head>
        <style>
            .carousel-item {
                height: 400px; /* 배너 높이 조절 */
            }

            .carousel-item img {
                object-fit: cover;
                height: 100%;
            }

            .carousel-caption {
                background: rgba(0, 0, 0, 0.5);
                padding: 20px;
                border-radius: 10px;
            }

            .carousel-caption h2 {
                font-size: 2.5rem;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .carousel-caption p {
                font-size: 1.2rem;
            }
        </style>
        <title>쇼핑몰 페이지</title>
    </head>
    <body>
        
        <!-- Header-->
        <!--<header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                </div>
            </div>
        </header> -->

        <!-- Header-->
        <header>
            <div id="mainCarousel" class="carousel slide" data-bs-ride="carousel">
                <!-- Indicators -->
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active"></button>
                    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1"></button>
                    <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2"></button>
                </div>

                <!-- Slides -->
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="https://via.placeholder.com/1920x400" class="d-block w-100" alt="Banner 1">
                        <div class="carousel-caption">
                            <h2>신상품 할인</h2>
                            <p>최대 30% 할인 진행중</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="https://via.placeholder.com/1920x400" class="d-block w-100" alt="Banner 2">
                        <div class="carousel-caption">
                            <h2>여름 시즌 오픈</h2>
                            <p>시원한 여름 상품 모음전</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img src="https://via.placeholder.com/1920x400" class="d-block w-100" alt="Banner 3">
                        <div class="carousel-caption">
                            <h2>회원 특별 혜택</h2>
                            <p>신규 회원 가입시 10% 할인쿠폰</p>
                        </div>
                    </div>
                </div>

                <!-- Controls -->
                <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>
            </div>
        </header>

        <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 캐러셀 초기화
            const myCarousel = document.getElementById('mainCarousel');
            const carousel = new bootstrap.Carousel(myCarousel, {
                interval: 5000,  // 5초
                wrap: true,      // 마지막 슬라이드에서 처음으로 순환
                ride: 'carousel' // 자동 재생 활성화
            });
        });
        </script>

        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center" id="productContainer">
                    <!-- 여기에 상품 리스트가 로드됩니다 -->
                </div>
            </div>
        </section>
        <!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Personal Project - Hyeok</p></div>
        </footer>
        
        
        <script>
        $(document).ready(function() {
            loadProducts();
        });

        function loadProducts() {
            $.ajax({
                url: '/homeProductList',
                type: 'GET',
                success: function(response) {
                    $('#productContainer').html(response);
                },
                error: function(xhr, status, error) {
                    console.error('상품 로드 실패:', error);
                }
            });
        }
        </script>
    </body>
</html>
