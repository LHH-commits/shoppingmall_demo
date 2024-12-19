<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="adminUI.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록 폼</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
	.hidden {
		display:none;
	}
</style>
<script src="//cdn.ckeditor.com/4.22.1/full/ckeditor.js"></script>
</head>
<body>
	<div class="container mt-5">
	<h2 class="mb-5">상품 등록</h2>
    <form id="productForm" action="/admin/insertProduct" method="post" enctype="multipart/form-data">
	      <!-- 1. 판매자 구분 -->
	      <div class="mb-3">
	        <label class="form-label">판매자 구분</label><br>
	        <div class="form-check form-check-inline">
	          <input class="form-check-input" type="radio" name="pSellerType" id="headquarter" value="본사매입" checked>
	          <label class="form-check-label" for="headquarter">본사매입</label>
	        </div>
	        <div class="form-check form-check-inline">
	          <input class="form-check-input" type="radio" name="pSellerType" id="partner" value="입점사">
	          <label class="form-check-label" for="partner">입점사</label>
	        </div>
	        
	        <!-- 판매자 입력란 (입점사 선택 시 표시) -->
	        <div id="defaultSeller" class="mt-2 hidden">
	          <label for="sellerName" class="form-label">판매자</label>
	          	<div class="col-md-4">
	          		<input type="text" class="form-control" name="pSeller" id="pSeller" placeholder="입점사 이름 입력">
	        	</div>
	        </div>
	      </div>
	      <!-- 2. 상품명 입력란 -->
	      <div class="mb-3">
	        <label for="productName" class="form-label">상품명</label>
	        <div class="col-md-4">
	        	<input type="text" class="form-control" name="pName" id="pName" placeholder="상품명 입력">
	        </div>
	      </div>
	
	      <!-- 3. 판매가 입력란 -->
	      <div class="mb-3">
	        <label for="productPrice" class="form-label">판매가</label>
	        <div class="col-md-4">
	        	<input type="number" class="form-control" name="pPrice" id="pPrice" placeholder="판매가 입력">
	        </div>
	      </div>
	       <!-- 4. 재고량 -->
	      <div class="mb-3">
	        <label class="form-label">재고량</label><br>
	        <div class="form-check form-check-inline">
	          <input class="form-check-input" type="radio" name="pStockType" id="stockPlenty" value="많음" checked>
	          <label class="form-check-label" for="stockPlenty">많음</label>
	        </div>
	        <div class="form-check form-check-inline">
	          <input class="form-check-input" type="radio" name="pStockType" id="stockNone" value="품절">
	          <label class="form-check-label" for="stockNone">품절</label>
	        </div>
	        <div class="form-check form-check-inline">
	          <input class="form-check-input" type="radio" name="pStockType" id="stockFew" value="잔여수량">
	          <label class="form-check-label" for="stockFew">잔여수량</label>
	        </div>
	        <!-- 잔여수량 입력란 (잔여수량 선택 시 표시) -->
	        <div id="defaultStock" class="mt-2 hidden">
	          <label for="stockQuantity" class="form-label">잔여 수량</label>
	          	<div class="col-md-4">
	          		<input type="text" class="form-control" name="pStock" id="pStock" placeholder="잔여 수량 입력">
	        	</div>
	        </div>
	        <!-- 5. 상품 이미지 업로드(썸네일용) -->
	        <div class="mb-3">
	        	<label for="productImage" class="form-label">상품 썸네일</label>
	        	<div class="col-md-4">
	        		<input type="file" class="form-control" name="productImage" id="productImage">
	        		<div class="mt-2">
	        			<img id="imagePreview" src="" alt="미리보기" style="max-width: 200px; display: none;">
	        		</div>  		
	        	</div>
	        </div>
	        
	        <!-- 6. 카테고리 선택(완성된 카테고리들) -->
	        <div class="mb-3">
			    <label for="categorySelect" class="form-label">카테고리</label>
			    <div class="row">
			        <div class="col-md-4">
			            <select class="form-select mb-2" name="cateId">
			                <option value="">분류 선택</option>
			                <c:forEach var="category" items="${tierCategory}">
			                    <option value="${category.cateId}">${category.path}</option>
			                </c:forEach>
			            </select>
			        </div>
			    </div>
			</div>
	      </div>

		  <!-- 7. 상품 상세 설명 -->
		<div class="mb-3">
			<label for="pDetail" class="form-label">상품 상세 설명</label>
			<textarea name="pDetail" id="pDetail"></textarea>
		</div>
	
	      <!-- 제출 버튼 -->
	      <div class="d-flex justify-content-start mb-4">
	      	<button type="submit" class="btn btn-primary">등록</button>
	      	<a href="/admin/product" class="btn btn-secondary ms-2">취소</a>
	      </div>
      </form>
		
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
CKEDITOR.replace('pDetail', {
    height: 400,
    language: 'ko',
    // 업로드 URL 설정
    filebrowserUploadUrl: '/upload/editor/image',
    filebrowserImageUploadUrl: '/upload/editor/image',
    // 불필요한 플러그인 제거
    removePlugins: 'exportpdf',
    // 필요한 플러그인만 활성화
    extraPlugins: 'uploadimage',
    // 이미지 업로드 설정
    image: {
        toolbar: ['ImageStyle:full', 'ImageStyle:side', '|', 'ImageTextAlternative'],
        upload: {
            types: ['jpeg', 'png', 'gif', 'bmp']
        }
    },
    // 툴바 설정
    toolbar: [
        { name: 'clipboard', items: ['Undo', 'Redo'] },
        { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike'] },
        { name: 'paragraph', items: ['NumberedList', 'BulletedList'] },
        { name: 'insert', items: ['Image'] },
        { name: 'styles', items: ['Format', 'Font', 'FontSize'] }
    ]
});

// 업로드 모니터링
CKEDITOR.on('instanceReady', function(ev) {
    var editor = ev.editor;
    
    editor.on('fileUploadRequest', function(evt) {
        console.log('업로드 요청:', evt);
    });
    
    editor.on('fileUploadResponse', function(evt) {
        console.log('업로드 응답:', evt);
        try {
            var response = JSON.parse(evt.data.fileLoader.xhr.responseText);
            console.log('응답 데이터:', response);
            if (response.uploaded && response.url) {
                evt.data.url = response.url;
            }
        } catch(e) {
            console.error('응답 처리 오류:', e);
        }
    });
});

	// 페이지 로드 시 기본 상태 설정
	window.onload = function() {
	  // 본사매입이 체크되어 있을 경우 판매자 입력란 비활성화
	  toggleSellerInput();
	  toggleStockInput();
	}
	
	// 판매자 구분에 따른 입력란 활성화/비활성화
	document.getElementById('partner').addEventListener('change', toggleSellerInput);
	document.getElementById('headquarter').addEventListener('change', toggleSellerInput);
	
	function toggleSellerInput() {
	  const sellerInput = document.getElementById('pSeller');
	  const defaultInput = document.getElementById('defaultSeller');
	  if (document.getElementById('partner').checked) {
	    defaultInput.classList.remove('hidden');
	    sellerInput.disabled = false;
	    sellerInput.value = '';
	  } else {
		  defaultInput.classList.add('hidden');
	    sellerInput.disabled = false;
	    sellerInput.value = '본사매입'; // 본사매입일 때만 이 값이 기본으로 나옵니다.
	  }
	}
	
	// 재고량에 따른 입력란 활성화/비활성화
	document.getElementById('stockFew').addEventListener('change', toggleStockInput);
	document.getElementById('stockPlenty').addEventListener('change', toggleStockInput);
	document.getElementById('stockNone').addEventListener('change', toggleStockInput);
	
	function toggleStockInput() {
	  const stockInput = document.getElementById('pStock');
	  const defaultStock = document.getElementById('defaultStock');
	  
	  if (document.getElementById('stockFew').checked) {
	    defaultStock.classList.remove('hidden');  // 잔여 수량 입력란 표시
	    stockInput.value = '';  // 사용자가 직접 수량을 입력해야 함
	  } else {
	    defaultStock.classList.add('hidden');  // 잔여 수량 입력란 숨김
	    
	    if (document.getElementById('stockPlenty').checked) {
	      stockInput.value = '많음';  // '많음' 값 설정
	    } else if (document.getElementById('stockNone').checked) {
	      stockInput.value = '품절';  // '품절' 값 설정
	    }
	  }
	}
	
	// 가격과 수량은 숫자만 입력할 수 있게
	document.getElementById('pStock').addEventListener('input', function(event) {
		  this.value = this.value.replace(/[^0-9]/g, '');  // 숫자 외 값 제거
	});
	
	document.getElementById('pPrice').addEventListener('input', function(event) {
		  this.value = this.value.replace(/[^0-9]/g, '');  // 숫자 외 값 제거
	});
	
	// 폼에 빈 곳이 있을경우 검증
	document.getElementById('productForm').addEventListener('submit', function(event){
		const productName = document.getElementById('pName').value.trim();
		const productPrice = document.getElementById('pPrice').value.trim();
		const stockInput = document.getElementById('pStock').value.trim();
		const sellerType = document.querySelector('input[name="pSellerType"]:checked').value;
		let errorMessage = '';
		
		if (sellerType === '입점사' && !document.getElementById('pSeller').value.trim()) {
			errorMessage = '판매자를 입력해주세요.';
		}
		
		else if (!productName) {
			errorMessage = '상품명을 입력해주세요.';
		}
		
		else if (!productPrice || isNaN(productPrice) || productPrice <= 0) {
			errorMessage = '판매가가 유효하지 않습니다.';
		}
		
		else if (document.getElementById('stockFew').checked && (!stockInput || isNaN(stockInput) || stockInput <= 0)) {
			errorMessage = '잔여 수량이 유효하지 않습니다.';
		}
	
		if (errorMessage) {
			event.preventDefault();
			alert(errorMessage);
		}
	});
	
	// 이미지 미리보기 스크립트
	document.getElementById('productImage').addEventListener('change', function(e) {
		const file = e.target.files[0];
		const preview = document.getElementById('imagePreview');
		
		if(file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				preview.src = e.target.result;
				preview.style.display = 'block';
			}
			reader.readAsDataURL(file);
		} else {
			preview.src = '';
			preview.style.display = 'none';
		}
	});
</script>
</body>
</html>