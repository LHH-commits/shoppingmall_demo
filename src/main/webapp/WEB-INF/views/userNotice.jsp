<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="homeUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <style>
        .notice-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .notice-table {
            border-top: 2px solid #333;
            margin-top: 20px;
        }
        .notice-table th {
            background-color: #f8f9fa;
            font-weight: 500;
        }
        .notice-title {
            color: #333;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.2s;
        }
        .notice-title:hover {
            color: #007bff;
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
<div class="notice-container">
    <h3 class="mb-4">고객센터</h3>
    <div class="board-tabs">
        <a href="/userNotice" class="tab-link active">공지사항</a>
        <a href="/userFAQ" class="tab-link">자주 묻는 질문</a>
    </div>
    
    <table class="table notice-table">
        <thead>
            <tr class="text-center">
                <th style="width: 10%">번호</th>
                <th style="width: 50%">제목</th>
                <th style="width: 15%">작성자</th>
                <th style="width: 15%">작성일</th>
                <th style="width: 10%">조회</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${bList}" var="board">
                <tr class="text-center">
                    <td>${board.bId}</td>
                    <td class="text-center">
                        <a href="/userBoardDetail?bId=${board.bId}&type=${type}" class="notice-title">${board.bTitle}</a>
                    </td>
                    <td>${board.bWriter}</td>
                    <td>${board.bDatetime}</td>
                    <td>${board.bViews}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <c:if test="${pagination.startPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="/userNotice?page=${pagination.prevPage}">이전</a>
                </li>
            </c:if>
            
            <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
                <li class="page-item <c:if test="${pagination.page == idx}">active</c:if>">
                    <a class="page-link" href="/userNotice?page=${idx}">${idx}</a>
                </li>
            </c:forEach>

            <c:if test="${pagination.endPage < pagination.lastPage}">
                <li class="page-item">
                    <a class="page-link" href="/userNotice?page=${pagination.nextPage}">다음</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
</body>
</html>