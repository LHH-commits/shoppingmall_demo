<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 회원 가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
    .fixed-size-box {
        width: 450px; /* 원하는 고정 너비 값 설정 */
    }
    
    .valid-feedback {
    	color: green;
    }
    
    .invalid-feedback {
    	color: red;
    }
    
    /* 유효성 검사 결과에 상관없이 항상 표시되도록 변경 */
	.valid-feedback, .invalid-feedback {
	    display: block !important; /* 피드백 메시지가 항상 보이도록 */
	}
    
    #passwordMatchMessage {
    	min-height: 20px; /* 메시지가 들어갈 최소 높이를 설정 */
	}
	
	#passwordMatchMessage {
    	font-size: 0.9em; /* 약간 작은 글자 크기 */
	}
</style>
</head>
<body>
	<div id="container">
		<div class="row justify-content-center mt-3">
			<div class="col-md-3 card mt-5 fixed-size-box">
				<div class="card-body">
					<h3 class="text-center mb-4 mt-4">관리자 회원가입</h3>
					<form action="/adminSignup" method="post" onsubmit="return validateForm()">
						<div data-mdb-input-init class="form-outline mb-4">
							<label class="form-label">아이디</label>
						    <input type="text" name="uId" class="form-control" required/>
					  	</div>
					  	
					  	<div data-mdb-input-init class="form-outline mb-4">
					  		<label class="form-label">비밀번호</label>
						    <input type="password" id="uPassword" name="uPassword" class="form-control" required/>
					  	</div>
					  	
					  	<div data-mdb-input-init class="form-outline mb-4">
						    <label class="form-label">비밀번호 확인</label>
						    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" onkeyup="passwordCheck()" required/>
							<div id="passwordMatchMessage" class="mt-1 ms-2"></div> <!-- 일치 여부 메시지 표시 -->
						</div>
					  	
					  	<div data-mdb-input-init class="form-outline mb-4">
					  		<label class="form-label">나이</label>
					  		<input type="text" name="uAge" class="form-control" required/>
					  	</div>
					  	
					  	<div data-mdb-input-init class="form-outline mb-4">
					  		<label class="form-label">폰번호</label>
					  		<div class="d-flex">
					  			<input type="text" id="uPhone1" class="form-control me-2" value="010" readonly style="width:80px;" required/>
					  			<input type="text" id="uPhone2" class="form-control me-2" maxlength="4" pattern="\d{4}" required style="width:100px;" 
					  			oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 4)" required/>
					  			<input type="text" id="uPhone3" class="form-control" maxlength="4" pattern="\d{4}" required style="width:100px;"
					  			oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 4)" required/>
					  		</div>
					  		<input type="hidden" id="uPhone" name="uPhone" />
					  	</div>
					  	
					  	<div data-mdb-input-init class="form-outline mb-4">
					  		<label class="form-label">상호명 혹은 이름</label>
					  		<input type="text" name="uName" class="form-control" required/>
					  	</div>
					  	
					  	<div data-mdb-input-init class="form-outline mb-4">
					  		<label class="form-label">사업장 주소</label>
					  		<input type="text" name="uAddress" class="form-control" required/>
					  	</div>
					  	
					  	<div class="d-flex justify-content-end align-items-center mb-2">
					  		<button type="submit" class="btn btn-primary btn-block mb-3 mt-2 w-100">가입하기</button>
					  	</div>
					  	<div class="d-flex justify-content-end align-items-center mb-2">
					  		<button type="button" class="btn btn-secondary btn-block mb-1 mt-1 w-100" onclick="location.href='/'">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		function passwordCheck() {
			const password = document.getElementById("uPassword").value;
			const confirmPassword = document.getElementById("confirmPassword").value;
			const checkMessage = document.getElementById("passwordMatchMessage");
			
			// 초기 메시지 스타일 제거
		    checkMessage.classList.remove("valid-feedback", "invalid-feedback");

		    if (password === confirmPassword && password !== "") {
		        checkMessage.textContent = "비밀번호가 일치합니다.";
		        checkMessage.classList.add("valid-feedback"); // 녹색 메시지
		    } else if (password !== confirmPassword && confirmPassword !== "") {
		        checkMessage.textContent = "비밀번호가 일치하지 않습니다.";
		        checkMessage.classList.add("invalid-feedback"); // 빨간 메시지
		    } else {
		        checkMessage.textContent = "";
		    }
		}
		
		// 폼 제출 전 확인 (폰 번호 합치기)
		function validateForm() {
			// 비밀번호 확인
			passwordCheck();
			
			// 폰번호 합치기
			combinePhoneNumber();

			// 추가적으로 폼 제출 조건을 여기에 넣을 수 있습니다.
			return true;
		}
	
		function combinePhoneNumber() {
			const phone1 = document.getElementById("uPhone1").value;
			const phone2 = document.getElementById("uPhone2").value;
			const phone3 = document.getElementById("uPhone3").value;
			
			document.getElementById("uPhone").value = phone1 + phone2 + phone3;
		}
	</script>
</body>
</html>