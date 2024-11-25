<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 관리</title>
</head>
<body>
	<div class="container mt-5">
		<div id="userTable"></div>
	</div>

<script>
	function loadUsers(page = 1) {
		$.ajax({
			url: '/userList?page=' + page,
			type: 'GET',
			success: function(response) {
				console.log(response);
				$('#userTable').html(response);
			}
		})
	}
	$(document).ready(function() {
		loadUsers();
	});
</script>
</body>
</html>