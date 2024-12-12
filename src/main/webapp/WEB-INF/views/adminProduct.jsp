<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 관리</title>
</head>
<body>
	<div class="container mt-5">
	<h2 class="text-center mt-3 mb-3">상품 관리</h2>
		<!-- 업데이트가 반영될 상품 테이블 -->
		<div id="productTable"></div>
		
	</div>

<script>
	function loadProducts(page = 1) {
		$.ajax({
			url: '/productList',
			type: 'GET',
			data: { page: page },
			success: function(response) {
				$('#productTable').html(response);
			},
			error: function(error) {
				console.error('Error loading products:', error);
			}
		});
	}
	
	function deleteSelectedProducts() {
		// 체크박스로 선택된 상품을 배열로
		let selectedProducts = [];
		
		// 체크된 productCheck를 가져오기
		$('input[name="productCheck"]:checked').each(function(){
			selectedProducts.push($(this).val());
		});
		
		// 확인용 코드
		console.log("선택 삭제 버튼 클릭");
		console.log(selectedProducts);
		
		if(selectedProducts.length > 0) {
			$.ajax({
				url: '/admin/deleteProduct',
				type: 'POST',
				data: {pIds: selectedProducts},
				traditional: true,
				success: function(response) {
					alert('삭제 완료');
					loadProducts();
				},
				error: function(error) {
					alert('삭제에 실패했습니다. 다시 시도해주세요.');
				}
			});
		} else {
			alert('삭제할 상품을 먼저 선택해주세요.');
		}
	}
	
	$(document).ready(function() {
		loadProducts(1);
		
		// .click사용 웬만하면 하지 말기
		// .click은 페이지가 처음 로드되는 DOM에만 이벤트를 줄 수 있음(ajax로 불러오는 방식은 안된다)
		// 그냥 .on 쓰기
		$(document).on('click', '#deleteSelected', function() {
			deleteSelectedProducts();
		});
	});

</script>
</body>
</html>