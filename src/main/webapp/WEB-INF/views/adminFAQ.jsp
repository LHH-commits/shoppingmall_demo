<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주묻는질문 관리</title>
<style>
    .table a {
        text-decoration: none;
        color: #333;
    }
    .table a:hover {
        color: #007bff;
    }
</style>
</head>
<body>
<div class="container mt-4">
    <h2>자주묻는질문 관리</h2>
    <div class="text-end mb-3">
        <a href="/admin/insertFAQ" class="btn btn-primary">글쓰기</a>
    </div>
    <table class="table">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${bList}" var="board">
                <tr>
                    <td>${board.bId}</td>
                    <td><a href="/admin/boardDetail?bId=${board.bId}&type=FAQ">${board.bTitle}</a></td>
                    <td>${board.bWriter}</td>
                    <td>${board.bDatetime}</td>
                    <td>${board.bViews}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- 페이징 처리 -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <c:if test="${pagination.startPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="/admin/faq?page=${pagination.prevPage}">&laquo;</a>
                </li>
            </c:if>
            
            <c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
                <li class="page-item <c:if test="${pagination.page == idx}">active</c:if>">
                    <a class="page-link" href="/admin/faq?page=${idx}">${idx}</a>
                </li>
            </c:forEach>

            <c:if test="${pagination.endPage < pagination.lastPage}">
                <li class="page-item">
                    <a class="page-link" href="/admin/faq?page=${pagination.nextPage}">&raquo;</a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
</body>
</html>