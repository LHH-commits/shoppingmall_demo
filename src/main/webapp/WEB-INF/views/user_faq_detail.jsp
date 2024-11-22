<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="homeUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰-FAQ-상세</title>
</head>
<body>
<div class="container mt-4">
    <h2>자주묻는질문 상세보기</h2>
    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">Q. ${board.bTitle}</h5>
                <small>작성일: ${board.bDatetime}</small>
            </div>
        </div>
        <div class="card-body">
            <div class="mb-3">
                <label class="form-label">작성자</label>
                <p class="form-control-static">${board.bWriter}</p>
            </div>
            <div class="mb-3">
                <label class="form-label">내용</label>
                <div class="border p-3 bg-light">
                   A. ${board.bContent}
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">조회수</label>
                <p class="form-control-static">${board.bViews}</p>
            </div>
        </div>
        <div class="card-footer">
            <div class="d-flex justify-content-between">
                <div>
                    <a href="/user/faq" class="btn btn-secondary">목록</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>