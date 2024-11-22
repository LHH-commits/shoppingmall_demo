<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div id="userList">
	<table class="table table-hover">
		<thead class="table-info">
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">이름</th>
				<th scope="col">폰번호</th>
				<th scope="col">회원등급</th>
				<th scope="col">가입일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="users" items="${uList}">
				<tr>
					<td>${users.row_num}</td>
					<td>${users.uId}</td>
					<td>${users.uName}</td>
					<td>${users.uPhone}</td>
					<td>${users.u_auth == 'ROLE_ADMIN' ? '관리자' : '일반회원'}</td>
					<td>${users.uDatetime}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<!-- 페이지네이션을 위한 코드 -->
	<nav>
		<ul class="pagination justify-content-center">
			<c:if test="${pagination.prevPage > 0}">
				<li class="page-item">
					<a class="page-link" href="#" onclick="loadProducts(${pagination.prevPage})" area-label="Previous">&laquo;</a>
				</li>
			</c:if>
			<c:forEach var="i" begin="${pagination.startPage }" end="${pagination.endPage }">
				<li class="page-item ${i == pagination.page ? 'active' : ''}">
					<a class="page-link" href="#" onclick="loadProducts(${i})">${i }</a>
				</li>
			</c:forEach>
			<c:if test="${pagination.nextPage <= pagination.lastPage}">
				<li class="page-item">
					<a class="page-link" href="#" onclick="loadProducts(${pagination.nextPage})" area-label="Next">&raquo;</a>
				</li>
			</c:if>
		</ul>
	</nav>
</div>