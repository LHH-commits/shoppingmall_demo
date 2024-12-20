<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container mt-4">
    <div class="card border-light">
        <div class="card-body">
            
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th scope="col" style="width: 80px;">번호</th>
                            <th scope="col" style="width: 150px;">아이디</th>
                            <th scope="col" style="width: 120px;">이름</th>
                            <th scope="col" style="width: 150px;">폰번호</th>
                            <th scope="col" style="width: 100px;">회원등급</th>
                            <th scope="col" style="width: 160px;">가입일</th>
                            <th scope="col" style="width: 120px;">총 주문금액</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="users" items="${uList}">
                            <tr>
                                <td class="align-middle">${users.row_num}</td>
                                <td class="align-middle">${users.uId}</td>
                                <td class="align-middle">${users.uName}</td>
                                <td class="align-middle">${users.uPhone}</td>
                                <td class="align-middle">
                                    <span class="badge ${users.u_auth == 'ROLE_ADMIN' ? 'bg-primary' : 'bg-secondary'}">
                                        ${users.u_auth == 'ROLE_ADMIN' ? '관리자' : '일반회원'}
                                    </span>
                                </td>
                                <td class="align-middle">${users.uDatetime}</td>
                                <td class="align-middle text-start">
                                    <c:choose>
                                        <c:when test="${users.totalOrderAmount > 0}">
                                            <fmt:formatNumber value="${users.totalOrderAmount}" pattern="#,###"/>원
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">0원</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${pagination.prevPage > 0}">
                        <li class="page-item">
                            <a class="page-link" href="#" 
                               onclick="loadProducts(${pagination.prevPage})">&laquo;</a>
                        </li>
                    </c:if>
                    
                    <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
                        <li class="page-item ${i == pagination.page ? 'active' : ''}">
                            <a class="page-link" href="#" 
                               onclick="loadProducts(${i})">${i}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${pagination.nextPage <= pagination.lastPage}">
                        <li class="page-item">
                            <a class="page-link" href="#" 
                               onclick="loadProducts(${pagination.nextPage})">&raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>