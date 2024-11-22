<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adminUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
</head>
<body>
<div class="container mt-4">
    <h2>공지사항 상세보기</h2>
    <div class="card">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0">${board.bTitle}</h5>
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
                    ${board.bContent}
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
                    <a href="/admin/notice" class="btn btn-secondary">목록</a>
                </div>
                <div>
                    <a href="/admin/editNotice?bId=${board.bId}&type=NOTICE" class="btn btn-primary">수정</a>
                    <button type="button" class="btn btn-danger" onclick="deleteBoard(${board.bId}, 'NOTICE')">삭제</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
function deleteBoard(bId, type) {
    if(confirm('정말 삭제하시겠습니까?')) {
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '/admin/deleteBoard';
        
        var bidInput = document.createElement('input');
        bidInput.type = 'hidden';
        bidInput.name = 'bId';
        bidInput.value = bId;
        form.appendChild(bidInput);
        
        var typeInput = document.createElement('input');
        typeInput.type = 'hidden';
        typeInput.name = 'type';
        typeInput.value = type;
        form.appendChild(typeInput);
        
        document.body.appendChild(form);
        form.submit();
    }
}
</script>
</body>
</html> 