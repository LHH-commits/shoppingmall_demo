<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="homeUI.jsp" %>    
<!DOCTYPE html>
<html>
    <head>
        <title>쇼핑몰 페이지</title>
    </head>
    <body>
        
        <!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">Shop in style</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                </div>
            </div>
        </header>
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
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; Personal Project</p></div>
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
