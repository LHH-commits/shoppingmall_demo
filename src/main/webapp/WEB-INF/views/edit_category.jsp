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
            <input type="hidden" name="parentId" id="finalParentId">
            
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
    
    <script type="text/javascript">
    $(document).ready(function() {
        const firstCategory = $('#firstCategory');
        const secondCategory = $('#secondCategory');
        const finalParentId = $('#finalParentId');
        
        let selectedSecondCategoryId = null;
        
        // categoryPath 데이터를 JavaScript 변수로 변환
        <c:forEach items="${categoryPath}" var="cat">
            <c:if test="${cat.cateId ne category.cateId}">
                <c:choose>
                    <c:when test="${cat.parentId eq null}">
                        console.log('1차 카테고리 설정:', '${cat.cateId}');
                        firstCategory.val('${cat.cateId}');
                    </c:when>
                    <c:otherwise>
                        console.log('2차 카테고리 저장:', '${cat.cateId}');
                        selectedSecondCategoryId = '${cat.cateId}';
                    </c:otherwise>
                </c:choose>
            </c:if>
        </c:forEach>
        
        // 초기 값 설정을 위한 함수
        function initializeCategories() {
            if (firstCategory.val()) {
                firstCategory.trigger('change');
            }
        }
        
        // 페이지 로드 후 약간의 지연을 두고 초기화 실행 (정확한 2차 카테고리로드를 위한 장치)
        setTimeout(initializeCategories, 100);
        
        // 2차는 1차를 선택했을때 활성화
        firstCategory.change(function() {
            const selectedId = $(this).val();
            console.log('1차 카테고리 선택됨:', selectedId);
            console.log('현재 selectedSecondCategoryId:', selectedSecondCategoryId);
            
            if (!selectedId) {
                secondCategory.prop('disabled', true);
                secondCategory.html('<option value="">=2차 카테고리 선택=</option>');
                finalParentId.val('');
                return;
            }

            secondCategory.prop('disabled', false);
            finalParentId.val(selectedId);

            $.ajax({
                url: '/admin/api/categories/options',
                method: 'GET',
                data: { 
                    parentId: selectedId,
                    excludeId: '${category.cateId}',
                    selectedId: selectedSecondCategoryId
                },
                success: function(html) {
                    console.log('AJAX 응답 받음');
                    console.log('응답 HTML:', html);
                    console.log('선택하려는 2차 카테고리 ID:', selectedSecondCategoryId);
                    
                    // HTML 적용 전에 임시 div에서 처리
                    const tempDiv = $('<div>').html(html);
                    const options = tempDiv.find('option');
                    console.log('받은 옵션 개수:', options.length);
                    
                    // 2차 카테고리 옵션 설정
                    secondCategory.empty().append(options);
                    
                    // 지연 실행으로 선택 처리
                    setTimeout(function() {
                        if (selectedSecondCategoryId) {
                            console.log('2차 카테고리 선택 시도:', selectedSecondCategoryId);
                            secondCategory.val(selectedSecondCategoryId);
                            console.log('선택 후 2차 카테고리 값:', secondCategory.val());
                            secondCategory.trigger('change');
                        }
                    }, 100);
                },
                error: function(xhr, status, error) {
                    console.error('카테고리 로드 실패:', error);
                    alert('카테고리 로드 중 오류가 발생했습니다.');
                }
            });
        });
        
        // 2차 카테고리 변경 시
        secondCategory.change(function(){
            const selectedId = $(this).val();
            if (selectedId) {
                finalParentId.val(selectedId);
            } else {
                finalParentId.val(firstCategory.val());
            }
        });
    });
    </script>
</body>
</html>
