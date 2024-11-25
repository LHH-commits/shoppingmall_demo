<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주묻는질문 등록</title>
</head>
<body>
<div class="container mt-4"></div>
    <h2>자주묻는질문 등록</h2>
    <form action="/admin/insertBoard" method="post">
        <input type="hidden" name="bType" value="${type}">
        <input type="hidden" name="uId" value="${uId}">
        <div class="mb-3">
            <label for="bTitle" class="form-label">질문</label>
            <input type="text" class="form-control" id="bTitle" name="bTitle" required>
        </div>
        <div class="mb-3">
            <label for="bContent" class="form-label">답변</label>
            <textarea class="form-control" id="bContent" name="bContent" rows="10" required></textarea>
        </div>
        <div class="mb-3">
            <label class="form-label">작성자</label>
            <input type="text" class="form-control" value="${uName}" readonly>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary">등록</button>
            <a href="/admin/faq" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>
</body>
</html>