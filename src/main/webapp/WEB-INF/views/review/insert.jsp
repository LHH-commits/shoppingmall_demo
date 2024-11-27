<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../homeUI.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품평 작성</title>
    <style>
        .review-form {
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
        }
        .product-info {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .star-rating {
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
    <div class="review-form">
        <h2 class="mb-4">상품평 작성</h2>
        
        <!-- 상품 정보 표시 -->
        <div class="product-info d-flex align-items-center">
            <img src="${product.pImgpath}" alt="${product.pName}" 
                 style="width: 100px; height: 100px; object-fit: cover; border-radius: 4px;">
            <div class="ms-3">
                <h5>${product.pName}</h5>
                <p class="mb-0 text-muted">판매자: ${product.pSeller}</p>
            </div>
        </div>

        <!-- 리뷰 작성 폼 -->
        <form id="reviewForm" class="mt-4">
            <input type="hidden" name="pId" value="${product.pId}">
            
            <!-- 별점 선택 -->
            <div class="mb-3">
                <label class="form-label">평점</label>
                <div class="star-rating">
                    <c:forEach begin="1" end="5" var="i">
                        <input type="radio" name="rScore" value="${i}" 
                               id="star${i}" class="star-radio" required>
                        <label for="star${i}" class="star-label">★</label>
                    </c:forEach>
                </div>
            </div>

            <!-- 리뷰 내용 -->
            <div class="mb-4">
                <label for="rContent" class="form-label">상품평</label>
                <textarea class="form-control" id="rContent" name="rContent" 
                          rows="5" required></textarea>
            </div>

            <!-- 버튼 -->
            <div class="d-flex justify-content-center gap-2">
                <button type="submit" class="btn btn-primary">등록하기</button>
                <button type="button" class="btn btn-secondary" 
                        onclick="history.back()">취소</button>
            </div>
        </form>
    </div>

    <script>
        // 별점 UI 처리
        document.querySelectorAll('.star-label').forEach(label => {
            label.addEventListener('click', function() {
                const score = this.getAttribute('for').replace('star', '');
                document.querySelectorAll('.star-label').forEach((l, index) => {
                    l.classList.toggle('checked', index < score);
                });
            });
        });

        // 폼 제출 처리
        document.getElementById('reviewForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = {
                pId: this.pId.value,
                rScore: this.rScore.value,
                rContent: this.rContent.value
            };

            fetch('/review/insert', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams(formData)
            })
            .then(response => response.text())
            .then(result => {
                alert(result);
                window.location.href = '/order/list';  // 주문 목록으로 돌아가기
            })
            .catch(error => {
                alert('리뷰 등록 중 오류가 발생했습니다.');
                console.error('Error:', error);
            });
        });
    </script>
</body>
</html>
