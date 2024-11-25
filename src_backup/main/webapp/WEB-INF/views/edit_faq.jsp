<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 수정</title>
</head>
<body>
<div class="container mt-4 mb-4" style="max-width: 800px;">
    <h2>FAQ 수정</h2>
    <form action="/admin/updateBoard" method="post">
    	<input type="hidden" name="bId" value="${board.bId}">
	    <input type="hidden" name="bType" value="${board.bType}">
	    <input type="hidden" name="bWriter" value="${board.bWriter}">
	    <input type="hidden" name="uId" value="${board.uId}">
        <div class="mb-3">
	    <label for="bTitle" class="form-label">제목</label>
		    <input type="text" class="form-control" id="bTitle" name="bTitle" value="${board.bTitle}" required>
		</div>
		<div class="mb-3">
		    <label for="bContent" class="form-label">내용</label>
		    <textarea class="form-control" id="bContent" name="bContent" rows="10" required>${board.bContent}</textarea>
		</div>
        <div class="mb-3">
            <label class="form-label">작성자</label>
            <input type="text" class="form-control" value="${board.bWriter}" readonly>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary">등록</button>
            <a href="/admin/faq" class="btn btn-secondary">취소</a>
        </div>
    </form>
</div>
</body>
</html>