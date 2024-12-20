<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="adminUI.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
</head>
<body>
	<div class="container">
		<h2 class="text-center my-4">카테고리 관리</h2>
		
		<!-- 카테고리 등록 폼 -->
		<div class="card mb-4 border-light">
			<div class="card-body">
				<form id="categoryForm" action="/admin/insertCategory" method="post">
					<input type="hidden" name="parentId" id="selectedParentId">
					
					<div class="mb-3">
						<label class="form-label">카테고리 소속</label>
						<div class="row">
							<div class="col-md-3">
								<select class="form-select" id="firstCategory" name="parentId">
									<option value="">=1차 카테고리 선택=</option>
									<c:forEach var="category" items="${topCategory}">
										<option value="${category.cateId}">${category.cateName}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-3">
								<select class="form-select" id="secondCategory" disabled>
									<option value="">=2차 카테고리 선택=</option>
								</select>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-4">
							<div class="mb-3">
								<label class="form-label" for="cateName">카테고리명</label>
								<input type="text" class="form-control" name="cateName" required>
							</div>
						</div>
					</div>
					
					<div class="text-end">
						<button type="submit" class="btn btn-primary">카테고리 추가</button>
					</div>
				</form>
			</div>
		</div>

		<!-- 카테고리 목록 -->
		<div class="card">
			<div class="card-body">
				<h4 class="card-title mb-3">카테고리 목록</h4>
				<table class="table table-hover">
					<thead class="table-light">
						<tr>
							<th scope="col" style="width: 10%">번호</th>
							<th scope="col" style="width: 25%">카테고리명</th>
							<th scope="col" style="width: 40%">분류</th>
							<th scope="col" style="width: 25%">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="category" items="${tierCategory}">
							<tr>
								<td class="align-middle">${category.cateId}</td>
								<td class="align-middle">
									<c:if test="${category.parentId != null}">
										<span class="text-muted">└</span>
									</c:if>
									${category.cateName}
								</td>
								<td class="align-middle">${category.path}</td>
								<td>
									<div class="btn-group">
										<a href="/admin/editCategory?cateId=${category.cateId}" 
										   class="btn btn-outline-secondary btn-sm">수정</a>
										<form action="/admin/deleteCategory" method="post" class="d-inline ms-1">
											<input type="hidden" name="cateId" value="${category.cateId}">
											<button type="button" class="btn btn-outline-danger btn-sm" 
													onclick="confirmDelete(this.form);">삭제</button>
										</form>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function(){
	        // 1차 카테고리 선택 시
	        $('#firstCategory').change(function(){
	            const parentId = $(this).val();
	            const secondCategory = $('#secondCategory');
	            
	            // 선택된 값이 없으면 2차 카테고리 비활성화
	            if(!parentId) {
	                secondCategory.prop('disabled', true);
	                secondCategory.html('<option value="">=2차 카테고리 선택=</option>');
	                $('#selectedParentId').val('');
	                return;
	            }
	            
	            // 2차 카테고리 활성화
	            secondCategory.prop('disabled', false);
	            
	            // 현재 선택된 1차 카테고리의 ID를 parentId로 설정
	            $('#selectedParentId').val(parentId);
	            
	            // AJAX로 하위 카테고리 HTML 옵션 로드
	            $.ajax({
	                url: '/api/categories/options',
	                method: 'GET',
	                data: { parentId: parentId },
	                success: function(html) {
	                    secondCategory.html(html);
	                },
	                error: function(xhr, status, error) {
	                    console.error('카테고리 로드 실패:', error);
	                    alert('카테고리 로드 중 오류가 발생했습니다.');
	                }
	            });
	        });
	
	        // 2차 카테고리 선택 시
	        $('#secondCategory').change(function(){
	            const selectedId = $(this).val();
	            if (selectedId) {
	                $('#selectedParentId').val(selectedId);
	            } else {
	                const firstCategoryId = $('#firstCategory').val();
	                $('#selectedParentId').val(firstCategoryId);
	            }
	        });
	    });
		
		function confirmDelete(form) {
		    if (confirm('이 카테고리를 삭제하면 모든 하위 카테고리도 함께 삭제됩니다. 계속하시겠습니까?')) {
		        form.submit();
		    }
		}
	</script>
</body>
</html>