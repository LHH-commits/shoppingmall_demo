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

    <!-- 주문 상세  모달 추가 -->
    <div class="modal fade" id="orderDetailModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">주문 상세 정보</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- 여기에 동적으로 주문 상세 정보가 로드됨 -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    loadOrderList(1);
});

function loadOrderList(page) {
    $.ajax({
        url: '/order/admin/orderList',
        type: 'GET',
        data: { page: page },
        success: function(response) {
            $('#orderListContainer').html(response);
        },
        error: function(error) {
            console.error('Error:', error);
            alert('주문 목록을 불러오는 중 오류가 발생했습니다.');
        }
    });
}

function updateStatus(status) {
    const selectedOrders = [];
    $('.chkOrder:checked').each(function() {
        selectedOrders.push($(this).val());
    });
    
    if (selectedOrders.length === 0) {
        alert('선택된 주문이 없습니다.');
        return;
    }

    $.ajax({
        url: '/order/admin/updateStatus',
        type: 'POST',
        data: {
            orderIds: selectedOrders,
            status: status
        },
        traditional: true,
        success: function(response) {
            if (response === 'success') {
                alert('배송상태가 업데이트되었습니다.');
                loadOrderList(1);
            } else {
                alert('배송상태 업데이트 중 오류가 발생했습니다.');
            }
        },
        error: function(error) {
            console.error('Error:', error);
            alert('배송상태 업데이트 중 오류가 발생했습니다.');
        }
    });
}
</script>
