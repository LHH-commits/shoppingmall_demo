<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<option value="">=2차 카테고리 선택=</option>
<c:forEach var="category" items="${subCategories}">
    <option value="${category.cateId}">${category.cateName}</option>
</c:forEach>