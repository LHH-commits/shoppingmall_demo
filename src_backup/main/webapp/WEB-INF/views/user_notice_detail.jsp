<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="homeUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>쇼핑몰-공지사항-상세</title>
    <style>
        .notice-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .notice-header {
            border-bottom: 2px solid #333;
            padding-bottom: 20px;
            margin-bottom: 30px;
        }
        .notice-title {
            font-size: 24px;
            font-weight: 500;
            margin-bottom: 15px;
        }
        .notice-info {
            color: #666;
            font-size: 14px;
        }
        .notice-content {
            min-height: 300px;
            line-height: 1.8;
            padding: 30px 0;
        }
        .notice-footer {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .btn-back {
            background-color: #333;
            color: white;
            padding: 8px 24px;
            border-radius: 4px;
            text-decoration: none;
            transition: background-color 0.2s;
        }
        .btn-back:hover {
            background-color: #555;
            color: white;
        }
    </style>
</head>
<body>
<div class="notice-container">
    <div class="notice-header">
        <h1 class="notice-title">${board.bTitle}</h1>
        <div class="notice-info">
            <span class="me-3">작성자: ${board.bWriter}</span>
            <span class="me-3">작성일: ${board.bDatetime}</span>
            <span>조회수: ${board.bViews}</span>
        </div>
    </div>
    
    <div class="notice-content">
        ${board.bContent}
    </div>
    
    <div class="notice-footer text-center">
        <a href="/userNotice" class="btn-back">목록으로 돌아가기</a>
    </div>
</div>
</body>
</html>