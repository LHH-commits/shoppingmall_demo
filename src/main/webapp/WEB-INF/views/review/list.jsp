<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../homeUI.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내가 작성한 리뷰</title>
    <link rel="stylesheet" type="text/css" href="/css/styles.css">
    <style>
        .review-list-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
        }
        .review-item {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .product-info {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
        .star-display {
            color: #ffd700;
            font-size: 18px;
        }
        .review-actions {
            margin-top: 15px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .modal-body .star-rating {
            display: flex;
            gap: 10px;
            margin: 20px 0;
        }
        .star-radio {
            display: none;
        }
        .star-label {
            cursor: pointer;
            font-size: 24px;
            color: #ddd;
        }
        .star-label.checked {
            color: #ffd700;
        }
    </style>
</head>
<body>
    <div class="review-list-container">
        <h2 class="mb-4">내가 작성한 리뷰</h2>
        
        <c:forEach items="${reviews}" var="review">
            <div class="review-item">
                <div class="product-info">
                    <img src="${review.product.pImgpath}" alt="${review.product.pName}" 
                         style="width: 80px; height: 80px; object-fit: cover; border-radius: 4px;">
                    <div class="ms-3">
                        <h5>${review.product.pName}</h5>
                        <p class="mb-0 text-muted">판매자: ${review.product.pSeller}</p>
                    </div>
                </div>
                
                <div class="star-display">
                    ${'★'.repeat(review.rScore)}${'☆'.repeat(5-review.rScore)}
                    <span class="text-muted">(${review.rScore}점)</span>
                </div>
                
                <div class="mt-2">
                    ${review.rContent}
                </div>
                
                <div class="text-muted small mt-2">
                    작성일: <fmt:formatDate value="${review.rDatetime}" 
                        pattern="yyyy년 MM월 dd일 HH : mm" />
                </div>
                
                <div class="review-actions">
                    <button class="btn btn-outline-primary btn-sm" 
                            data-rid="${review.rId}" data-content="${review.rContent}" data-score="${review.rScore}" 
                            onclick="openEditModal(${review.rId}, '${review.rContent}', ${review.rScore})">
                        수정
                    </button>
                    <input type="hidden" name="rId" value="${review.rId}">
                    <button class="btn btn-outline-danger btn-sm"
                        onclick="deleteReview(${review.rId})">
                        삭제
                    </button>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty reviews}">
            <div class="text-center text-muted py-5">
                <p>작성한 리뷰가 없습니다.</p>
            </div>
        </c:if>
    </div>

    <!-- 수정 모달 -->
    <div class="modal fade" id="editModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">리뷰 수정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="editForm">
                        <input type="hidden" id="editRId" name="rId">
                        
                        <div class="mb-3">
                            <label class="form-label">평점</label>
                            <div class="star-rating">
                                <c:forEach begin="1" end="5" var="i">
                                    <input type="radio" name="rScore" value="${i}" 
                                           id="editStar${i}" class="star-radio" required>
                                    <label for="editStar${i}" class="star-label">★</label>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="editContent" class="form-label">리뷰 내용</label>
                            <textarea class="form-control" id="editContent" 
                                      name="rContent" rows="5" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" 
                            data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" 
                            onclick="updateReview()">수정하기</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 별점 UI 처리 함수
        function updateStarDisplay(score) {
            document.querySelectorAll('.star-label').forEach((label, index) => {
                label.classList.toggle('checked', index < score);
            });
        }

        // 모달 내 별점 클릭 이벤트
        document.querySelectorAll('.star-radio').forEach(radio => {
            radio.addEventListener('change', function() {
                const score = this.value;
                updateStarDisplay(score);
            });
        });

        function deleteReview(rId) {
            if (!confirm('정말 이 리뷰를 삭제하시겠습니까?')) return;

            const formData = new URLSearchParams();
            formData.append('rId', rId);

            fetch('/review/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            })
            .then(response => {
                if (!response.ok) throw new Error('서버 응답 오류');
                return response.text();
            })
            .then(result => {
                alert('리뷰가 삭제되었습니다.');
                location.href = '/review/list';
            })
            .catch(error => {
                console.error('Error:', error);
                alert('리뷰 삭제 중 오류가 발생했습니다.');
            });
        }

        function updateReview() {
            const form = document.getElementById('editForm');
            const formData = new URLSearchParams();
            formData.append('rId', form.rId.value);
            formData.append('rScore', document.querySelector('input[name="rScore"]:checked').value);
            formData.append('rContent', form.rContent.value);

            fetch('/review/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('서버 응답 오류');
                }
                return response.text();
            })
            .then(result => {
                alert('리뷰가 수정되었습니다.');
                location.href = '/review/list';  // 리스트 페이지로 리다이렉트
            })
            .catch(error => {
                console.error('Error:', error);
                alert('리뷰 수정 중 오류가 발생했습니다.');
            });
        }

        function openEditModal(rId, content, score) {
            const editRIdInput = document.getElementById('editRId');
            const editContentInput = document.getElementById('editContent');
            const editStarInput = document.getElementById(`editStar${score}`);
            
            if (editRIdInput) editRIdInput.value = rId;
            if (editContentInput) editContentInput.value = content;
            if (editStarInput) editStarInput.checked = true;
            
            // 별점 UI 업데이트
            updateStarDisplay(score);
            
            const modal = new bootstrap.Modal(document.getElementById('editModal'));
            modal.show();
        }

        // 페이지 로드 시 별점 이벤트 리스너 등록
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.star-radio').forEach(radio => {
                radio.addEventListener('change', function() {
                    const score = this.value;
                    updateStarDisplay(score);
                });
            });
        });
    </script>
</body>
</html>
