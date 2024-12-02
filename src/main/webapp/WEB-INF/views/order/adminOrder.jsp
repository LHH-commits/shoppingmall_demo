<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../adminUI.jsp" %>

<div class="container mt-4">
    <div class="row">
        <div class="col">
            <h2>주문 관리</h2>
        </div>
    </div>

    <!-- 배송상태 변경 버튼 그룹 추가 -->
    <div class="row mb-3">
        <div class="col">
            <div class="btn-group">
                <button class="btn btn-primary" onclick="updateStatus('배송준비중')">배송준비중</button>
                <button class="btn btn-info" onclick="updateStatus('배송중')">배송중</button>
                <button class="btn btn-success" onclick="updateStatus('배송완료')">배송완료</button>
            </div>
        </div>
    </div>

    <!-- 주문 목록이 로드될 영역 -->
    <div id="orderListContainer">
        <!-- 여기에 orderList.jsp가 로드됨 -->
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    loadOrderList(1);
});

function loadOrderList(page) {
    fetch('/order/admin/orderList?page=' + page)
        .then(response => response.text())
        .then(html => {
            document.getElementById('orderListContainer').innerHTML = html;
        })
        .catch(error => {
            console.error('Error:', error);
            alert('주문 목록을 불러오는 중 오류가 발생했습니다.');
        });
}

function updateStatus(status) {
    const checkedOrders = document.querySelectorAll('.chkOrder:checked');
    if (checkedOrders.length === 0) {
        alert('선택된 주문이 없습니다.');
        return;
    }

    const orderIds = Array.from(checkedOrders).map(checkbox => checkbox.value).join(',');

    fetch('/order/admin/updateStatus', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: `orderIds=${orderIds}&status=${status}`
    })
    .then(response => response.text())
    .then(result => {
        if (result === 'success') {
            alert('배송상태가 업데이트되었습니다.');
            loadOrderList(1);  // 목록 새로고침
        } else {
            alert('배송상태 업데이트 중 오류가 발생했습니다.');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('배송상태 업데이트 중 오류가 발생했습니다.');
    });
}
</script>
