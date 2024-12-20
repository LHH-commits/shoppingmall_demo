<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container mt-4">
	<table class="table table-hover">
		<thead class="table-light">
			<tr>
				<th scope="col" class="text-center" style="width: 50px;">
					<input type="checkbox" class="form-check-input" id="checkAll">
				</th>
				<th scope="col" style="width: 80px;">번호</th>
				<th scope="col" style="width: 120px;">판매자</th>
				<th scope="col">상품명</th>
				<th scope="col" style="width: 250px;">분류</th>
				<th scope="col" style="width: 120px;">등록일</th>
				<th scope="col" style="width: 100px;">가격</th>
				<th scope="col" style="width: 80px;">재고</th>
				<th scope="col" style="width: 80px;">수정</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="product" items="${pList}">
				<tr>
					<td class="text-center">
						<input type="checkbox" class="form-check-input chkPdt" name="productCheck" value="${product.pId}">
					</td>
					<td class="align-middle">${product.pId}</td>
					<td class="align-middle">${product.pSeller}</td>
					<td class="align-middle">
						<div class="d-flex align-items-center">
							<c:if test="${not empty product.pImgpath}">
								<img src="${pageContext.request.contextPath}${product.pImgpath}" 
									 alt="상품 이미지" 
									 style="width: 40px; height: 40px; object-fit: cover; border-radius: 4px; margin-right: 10px;">
							</c:if>
							<span>${product.pName}</span>
						</div>
					</td>
					<td class="align-middle">${product.catePath}</td>
					<td class="align-middle">${product.pUptime}</td>
					<td class="align-middle text-end">${product.pPrice}원</td>
					<td class="align-middle text-center">${product.pStock}</td>
					<td class="align-middle">
						<a href="/admin/editProduct?pId=${product.pId}" 
						   class="btn btn-outline-secondary btn-sm">수정</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 페이지네이션 -->
	<nav>
		<ul class="pagination justify-content-center">
			<c:if test="${pagination.prevPage > 0}">
				<li class="page-item">
					<a class="page-link" href="#" onclick="loadProducts(${pagination.prevPage})">&laquo;</a>
				</li>
			</c:if>
			<c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
				<li class="page-item ${i == pagination.page ? 'active' : ''}">
					<a class="page-link" href="#" onclick="loadProducts(${i})">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${pagination.nextPage <= pagination.lastPage}">
				<li class="page-item">
					<a class="page-link" href="#" onclick="loadProducts(${pagination.nextPage})">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</nav>
	
	<div class="d-flex justify-content-between align-items-center mt-3">
		<button id="deleteSelected" class="btn btn-outline-danger">선택 삭제</button>
		<a href="/admin/insertProduct" class="btn btn-primary">상품 등록</a>
	</div>
</div>

<script>
    // 전체 선택 체크박스 이벤트를 document에 위임
    $(document).on('change', '#checkAll', function() {
        const isChecked = $(this).prop('checked');
        $('.chkPdt').prop('checked', isChecked);
    });
    
    // 개별 체크박스 이벤트를 document에 위임
    $(document).on('change', '.chkPdt', function() {
        const totalCheckboxes = $('.chkPdt').length;
        const checkedCheckboxes = $('.chkPdt:checked').length;
        $('#checkAll').prop('checked', totalCheckboxes === checkedCheckboxes);
    });
</script>