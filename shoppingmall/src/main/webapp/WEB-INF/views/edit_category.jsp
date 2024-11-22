<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="adminUI.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 수정</title>
</head>
<body>
    <div class="container">
        <h2 class="text-center mt-3 mb-3">카테고리 수정</h2>
        <form action="/admin/updateCategory" method="post">
            <input type="hidden" name="cateId" value="${category.cateId}">
            <label class="form-label">카테고리 소속</label>
            <div class="row mb-3">
                <div class="col-md-2">
                    <!-- 1차 카테고리 선택 드롭다운 -->
                    <!-- 멍청하게 name="parentId"를 2개나 사용해서 넘겨주니까 값이 2개가 되어 제대로 전달 안된거였음 -->
                    <!-- 위의 parentId를 지워서 해결 -->
                    <select class="form-select" id="firstCategory">
                        <option value="">=1차 카테고리 선택=</option>
                        <c:forEach var="cat" items="${topCategory}">
                            <option value="${cat.cateId}" 
                                    <c:if test="${cat.cateId == category.parentId}">selected</c:if>>
                                ${cat.cateName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="col-md-2">
                    <!-- 2차 카테고리 선택 드롭다운 -->
                    <select class="form-select" id="secondCategory" disabled>
                        <option value="">=2차 카테고리 선택=</option>
                    </select>
                </div>
            </div>
            <input type="hidden" name="parentId" id="finalParentId">
            <div class="mb-3 col-md-4">
                <label class="form-label" for="cateName">카테고리명</label>
                <input type="text" class="form-control" name="cateName" value="${category.cateName}" required>
            </div>
            
            <div class="d-flex justify-content-end align-items-center mt-3">
                <button type="submit" class="btn btn-sm btn-primary">저장</button>
                <a href="/admin/category" class="btn btn-sm btn-secondary ms-2">취소</a>
            </div>
        </form>
    </div>
    
    <script>
        $(document).ready(function() {
        	const firstCategory = $('#firstCategory');
            const secondCategory = $('#secondCategory');
            const finalParentId = $('#finalParentId');
        	
        	// 2차는 1차를 선택했을때 활성화
            firstCategory.change(function() {
                const selectedId = $(this).val();
                
                if (!selectedId) {
                    secondCategory.prop('disabled', true);
                    secondCategory.html('<option value="">=2차 카테고리 선택=</option>');
                    finalParentId.val('');
                    return;
                }

                secondCategory.prop('disabled', false);
                finalParentId.val(selectedId);

                $.ajax({
                    url: '/api/categories/options',
                    method: 'GET',
                    data: { 
                    	parentId: selectedId,
                    	excludeId: '${category.cateId}'
                    },
                    success: function(html) {
                    	secondCategory.html(html);
                        const selectedParentId = '${category.parentId}';
                        if (selectedParentId) {
                            secondCategory.val(selectedParentId);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('카테고리 로드 실패:', error);
                        alert('카테고리 로드 중 오류가 발생했습니다.');
                    }
                });
            });
        	
            secondCategory.change(function(){
            	const selectedId = $(this).val();
            	if (selectedId) {
            		finalParentId.val(selectedId);
            	} else {
            		finalParentId.val(firstCategory.val());
            	}
            });

            if ($('#firstCategory').val()) {
                $('#firstCategory').trigger('change');
            }
        });
    </script>
</body>
</html>
