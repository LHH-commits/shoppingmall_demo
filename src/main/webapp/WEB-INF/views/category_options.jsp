<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<option value="">=2차 카테고리 선택=</option>
<c:forEach var="category" items="${subCategories}">
    <%-- 디버깅을 위한 주석 --%>
    <%-- 현재 카테고리: ${category.cateId}, selectedId: ${selectedId} --%>
    <option value="${category.cateId}" 
            <c:if test="${category.cateId == selectedId}">selected="selected"</c:if>>
        ${category.cateName}
    </option>
</c:forEach>