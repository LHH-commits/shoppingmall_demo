<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="homeUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자주 묻는 질문</title>
    <style>
        .faq-item {
            border: 1px solid #eee;
            margin-bottom: 10px;
            border-radius: 5px;
        }
        .faq-question {
            padding: 15px 20px;
            background-color: #f8f9fa;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .faq-question:hover {
            background-color: #e9ecef;
        }
        .faq-answer {
            padding: 20px;
            display: none;
            background-color: #fff;
            border-top: 1px solid #eee;
        }
        .page-link {
            color: #333;
            border: none;
            margin: 0 5px;
        }
        .page-link:hover {
            color: #007bff;
            background: none;
        }
        .page-item.active .page-link {
            background-color: #333;
            border-color: #333;
        }
        .faq-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        /* 탭 스타일 추가 */
        .board-tabs {
            margin-bottom: 30px;
            border-bottom: 2px solid #eee;
        }
        .board-tabs .tab-link {
            display: inline-block;
            padding: 10px 20px;
            color: #666;
            text-decoration: none;
            margin-right: 20px;
            position: relative;
        }
        .board-tabs .tab-link.active {
            color: #333;
            font-weight: 500;
        }
        .board-tabs .tab-link.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: #333;
        }
        .board-tabs .tab-link:hover {
                color: #333;
        }
    </style>
</head>
<body>
<div class="faq-container">
    <h3 class="mb-4">고객센터</h3>
    <div class="board-tabs">
        <a href="/userNotice" class="tab-link">공지사항</a>
        <a href="/userFAQ" class="tab-link active">자주 묻는 질문</a>
    </div>
    
    <div class="faq-container">
        <c:forEach items="${bList}" var="board">
            <div class="faq-item">
                <div class="faq-question" onclick="toggleAnswer(this)">
                    <span>Q. ${board.bTitle}</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>A. ${board.bContent}</p>
                    <small class="text-muted">
                        작성자: ${board.bWriter} | 작성일: ${board.bDatetime}
                    </small>
                </div>
            </div>
        </c:forEach>
    </div>

    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <c:if test="${pagination.startPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="/userFAQ?page=${pagination.prevPage}">이전</a>
                </li>
            </c:if>
            
            <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
                <li class="page-item <c:if test="${pagination.page == idx}">active</c:if>">
                    <a class="page-link" href="/userFAQ?page=${idx}">${idx}</a>
                </li>
            </c:forEach>

            <c:if test="${pagination.endPage < pagination.lastPage}">
                <li class="page-item">
                    <a class="page-link" href="/userFAQ?page=${pagination.nextPage}">다음</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>

<script>
function toggleAnswer(element) {
    const answer = element.nextElementSibling;
    const icon = element.querySelector('i');
    
    if (answer.style.display === 'block') {
        answer.style.display = 'none';
        icon.classList.remove('fa-chevron-up');
        icon.classList.add('fa-chevron-down');
    } else {
        answer.style.display = 'block';
        icon.classList.remove('fa-chevron-down');
        icon.classList.add('fa-chevron-up');
    }
}
</script>
</body>
</html>