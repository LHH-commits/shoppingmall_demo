<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div id="productList">
	<table class="table table-hover">
		<thead class="table-info">
			<tr>
				<th scope="col">전체<input type="checkbox" class="form-check-input" id="checkAll"></th>
				<th scope="col">번호</th>
				<th scope="col">판매자</th>
				<th scope="col">상품명</th>
				<th scope="col">분류</th>
				<th scope="col">등록일</th>
				<th scope="col">가격</th>
				<th scope="col">재고</th>
				<th scope="col">수정</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="product" items="${pList}">
				<tr>
					<td><input type="checkbox" class="form-check-input chkPdt" name="productCheck" value="${product.pId}"></td>
					<td><strong>${product.pId}</strong></td>
					<td>${product.pSeller }</td>
					<td>
					    <c:if test="${not empty product.pImgpath}">
					        <img src="${pageContext.request.contextPath}${product.pImgpath}" alt="상품 이미지" style="width: 50px; height: 50px; object-fit: cover;">
					    </c:if>
					    ${product.pName}
					</td>
					<td>${product.catePath}</td>
					<td>${product.pUptime }</td>
					<td>${product.pPrice }</td>
					<td>${product.pStock }</td>
					<td><a href="/admin/editProduct?pId=${product.pId}" class="btn btn-sm btn-success">수정</a>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- 페이지네이션을 위한 코드 -->
	<nav>
		<ul class="pagination justify-content-center">
			<c:if test="${pagination.prevPage > 0}">
				<li class="page-item">
					<a class="page-link" href="#" onclick="loadProducts(${pagination.prevPage})" area-label="Previous">&laquo;</a>
				</li>
			</c:if>
			<c:forEach var="i" begin="${pagination.startPage }" end="${pagination.endPage }">
				<li class="page-item ${i == pagination.page ? 'active' : ''}">
					<a class="page-link" href="#" onclick="loadProducts(${i})">${i }</a>
				</li>
			</c:forEach>
			<c:if test="${pagination.nextPage <= pagination.lastPage}">
				<li class="page-item">
					<a class="page-link" href="#" onclick="loadProducts(${pagination.nextPage})" area-label="Next">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</nav>
	
	<div class="d-flex justify-content-between align-items-center mb-4">
    	<button id="deleteSelected" class="btn btn-danger btn-md">선택 삭제</button>
    	
    	<a href="/admin/insertProduct" class="btn btn-primary btn-md">상품 등록</a>
    </div>
</div>

<script>
	document.getElementById('checkAll').addEventListener('change', function(){
		const isChecked = this.checked;
		const checkboxes = document.querySelectorAll('.chkPdt');
		
		checkboxes.forEach(function(checkbox){
			checkbox.checked = isChecked;
		});
	});
	
	const checkboxes = document.querySelectorAll('.chkPdt');
	checkboxes.forEach(function(checkbox) {
		checkbox.addEventListener('change', function(){
			const allChecked = document.querySelectorAll('.chkPdt:checked').length === checkboxes.length;
			document.getElementById('checkAll').checked = allChecked;
		});
	});
	
</script>