<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>쇼핑몰 관리자 UI</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<link href="headers.css" rel="stylesheet">
<style>
	.logo-link {
		text-decoration: none;
	}
	/* 현재 페이지 메뉴 스타일 */
	.nav-link.active {
		border-bottom: 2px solid white;
	}
	.nav-link.active-main {
		border-bottom: 2px solid #6c757d;  /* text-secondary 색상과 동일 */
	}
</style>
</head>
<body>
<header>
	<div class="px-3 py-1 bg-dark mb-0">
      <div class="container">
        <div class="d-flex justify-content-between align-items-center">
          <div class="d-flex align-items-center">
            <a href="/admin/main" class="logo-link"><h4 class="text-white mb-0">쇼핑몰 관리자</h4></a>
          </div>

          <div class="text-end">
            <a href="/userHome" class="btn btn-info btn-sm">쇼핑몰</a>
            <a href="/logout" class="btn btn-secondary btn-sm">로그아웃</a>
          </div>
        </div>
      </div>
    </div>
    <div class="px-2 py-2 bg-dark text-white">
      <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">

          <ul class="nav col-12 col-lg-auto my-2 justify-content-center my-md-0 text-small">
            <li class="nav-item">
              <a href="/admin/main" class="nav-link text-secondary">
                메인
              </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-white"
              	 href="#"
              	 id="productDropdown"
              	 role="button"
              	 data-bs-toggle="dropdown"
              	 aria-expanded="false">
                상품관리
              </a>
              <ul class="dropdown-menu" aria-labelledby="productDropdown">
                <li><a class="dropdown-item" href="/admin/product">상품 리스트</a></li>
                <li><a class="dropdown-item" href="/admin/category">카테고리 관리</a></li>
              </ul>
            </li>
            <li class="nav-item">
              <a href="/order/admin/order" class="nav-link text-white">
                주문관리
              </a>
            </li>
            <li class="nav-item">
              <a href="/admin/users" class="nav-link text-white">
                회원관리
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link dropdown-toggle text-white"
              	 href="#"
              	 id="boardDropdown"
              	 role="button"
              	 data-bs-toggle="dropdown"
              	 aria-expanded="false">
                게시판관리
              </a>
              <ul class="dropdown-menu" aria-labelledby="boardDropdown">
                <li><a class="dropdown-item" href="/admin/notice">공지사항</a></li>
                <li><a class="dropdown-item" href="/admin/faq">자주묻는질문</a></li>
              </ul>
            </li>
            <li class="nav-item">
              <a href="/admin/chart" class="nav-link text-white">
                통계/분석
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </header>

  <script>
      $(document).ready(function() {
          // 현재 URL 경로 가져오기
          const path = window.location.pathname;
          
          // 각 메뉴 항목에 대해 현재 페이지 체크
          if (path === '/admin/main') {
              $('.nav-link:contains("메인")').addClass('active-main');
          } else if (path.includes('/admin/product') || path.includes('/admin/category')) {
              $('.nav-link:contains("상품관리")').addClass('active');
          } else if (path.includes('/order/admin/order')) {
              $('.nav-link:contains("주문관리")').addClass('active');
          } else if (path.includes('/admin/users')) {
              $('.nav-link:contains("회원관리")').addClass('active');
          } else if (path.includes('/admin/notice') || path.includes('/admin/faq')) {
              $('.nav-link:contains("게시판관리")').addClass('active');
          } else if (path.includes('/admin/chart')) {
              $('.nav-link:contains("통계/분석")').addClass('active');
          }
      });
  </script>

</body>
</html>