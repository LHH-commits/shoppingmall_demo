<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
    .fixed-size-box {
        width: 400px; /* 원하는 고정 너비 값 설정 */
    }
</style>
</head>
<body>
	<div id="container">
		<div class="row justify-content-center mt-5">
			<div class="col-md-2 card mt-5 fixed-size-box">
				<div class="card-body">
					<h3 class="text-center mb-4 mt-4"><strong>통합 로그인</strong></h3>
					<form action="/loginPro" method="post">
						<div data-mdb-input-init class="form-outline mb-4">
							<label class="form-label">아이디</label>
						    <input type="text" name="uId" class="form-control"/>
					  	</div>
					  	
					  	<div data-mdb-input-init class="form-outline mb-4">
					  		<label class="form-label">비밀번호</label>
						    <input type="password" name="uPassword" class="form-control" />
					  	</div>
					  	<div class="d-flex justify-content-end align-items-center mb-2">
						  	<div class="form-check">
						  		<input class="form-check-input" type="checkbox" id="remember_me" name="remember-me"/>
						  		<label class="form-check-label" for="flexCheckDefault">
									자동 로그인
								</label>
							</div>
					  	</div>
					  	<div class="d-flex justify-content-end align-items-center mb-2">
					  		<button type="submit" class="btn btn-primary btn-block mb-3 mt-2 w-100">로그인</button>
					  	</div>
					</form>
					<div class="text-center mb-2">
						<small>관리자 계정이 없으신가요? <a href="/adminBeforesignup"><br>회원가입하기</a></small>
					</div>
					<div class="text-center mb-2">
						<small>회원 계정이 없으신가요? <a href="/userBeforesignup"><br>회원가입하기</a></small>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>