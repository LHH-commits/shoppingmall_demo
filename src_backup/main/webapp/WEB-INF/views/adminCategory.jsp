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
		<h2 class="text-center mt-3 mb-3">카테고리 관리</h2>
		<form id="categoryForm" action="/admin/insertCategory" method="post">
			<input type="hidden" name="parentId" id="selectedParentId">
			<label class="form-label">카테고리 소속</label>
			<div class="row">
				<div class="col-md-2">
					<!-- 옆으로 나란히 2개정도의 드랍다운(1차, 2차분류)을 만들어서
						 고를 수 있게하고 선택하지 않았다면 최상위 카테고리로 등록 -->
					<select class="form-select" id="firstCategory" name="parentId">
                        <option value="">=1차 카테고리 선택=</option>
                        <c:forEach var="category" items="${topCategory}">
                            <option value="${category.cateId}">${category.cateName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <select class="form-select" id="secondCategory" disabled>
                        <option value="">=2차 카테고리 선택=</option>
                    </select>
                </div>
			</div>
			<input type="hidden" name="parentId" id="selectedParentId">
			<div class="mt-3 col-md-4">
				<label class="form-label" for="cateName">카테고리명</label>
				<input type="text" class="form-control" name="cateName" required>
			</div>
			<div class="d-flex justify-content-end align-items-center mt-3">
				<button type="submit" class="btn btn-sm btn-primary">카테고리 추가</button>
			</div>
		</form>
		<h4 class="mt-2 mb-2">카테고리 목록</h4>
		<table class="table table-hover">
			<thead class="table-info">
				<tr>
					<th scope="col" width="10%">번호</th>
					<th scope="col" width="25%">카테고리명</th>
					<th scope="col" width="40%">분류</th>
					<th scope="col" width="30%">관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="category" items="${tierCategory}">
			        <tr>
			            <td><strong>${category.cateId}</strong></td>
			            <td>
			                <c:if test="${category.parentId != null}">
			                    <span class="text-muted">└</span>
			                </c:if>
			                ${category.cateName}
			            </td>
			            <td>${category.path}</td>
			            <td>
			                <a href="/admin/editCategory?cateId=${category.cateId}" class="btn btn-sm btn-outline-success me-1">수정</a>
			                <form action="/admin/deleteCategory" method="post" style="disabled:inline;">
			                	<input type="hidden" name="cateId" value="${category.cateId }">
				                <button type="button" class="btn btn-sm btn-outline-secondary me-1" 
	                                    onclick="confirmDelete(this.form);">삭제</button>
                            </form>
			            </td>
			        </tr>
			    </c:forEach>
			</tbody>
		</table>
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