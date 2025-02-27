<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
/* 체크박스 스타일 커스터마이징 */
.form-check-input {
    border: 2px solid #dee2e6;  /* 테두리 굵기와 색상 조정 */
    opacity: 1;                 /* 투명도 제거 */
}

.form-check-input:hover {
    border-color: #6c757d;      /* 호버 시 테두리 색상 */
    cursor: pointer;            /* 호버 시 커서 변경 */
}

.form-check-input:checked {
    background-color: #0d6efd;  /* 체크 시 배경색 */
    border-color: #0d6efd;      /* 체크 시 테두리 색상 */
}
</style>

<!-- 주문 목록 테이블 -->
<div class="table-responsive">
    <table class="table table-hover">
        <thead class="table-light">
            <tr>
                <th class="text-center" style="width: 50px;">
                    <input type="checkbox" class="form-check-input" id="checkAll" 
                           style="width: 20px; height: 20px;">
                </th>
                <th style="width: 160px;">주문일시</th>
                <th style="width: 120px;">주문번호</th>
                <th style="width: 120px;">주문인</th>
                <th style="width: 120px;">주문금액</th>
                <th style="width: 120px;">배송상태</th>
                <th style="width: 100px;">주문상세</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td class="text-center">
                        <input type="checkbox" class="form-check-input chkOrder" 
                               value="${order.oId}" style="width: 20px; height: 20px;">
                    </td>
                    <td class="align-middle">
                        <fmt:formatDate value="${order.orders.oDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </td>
                    <td class="align-middle">${order.oId}</td>
                    <td class="align-middle">${order.orders.user.uName}</td>
                    <td class="align-middle text-start">
                        <fmt:formatNumber value="${order.orders.totalPrice}" pattern="#,###"/>원
                    </td>
                    <td class="align-middle">
                        <span class="badge bg-${order.odDeliveryStatus eq '배송준비중' ? 'secondary' : 
                                            order.odDeliveryStatus eq '배송중' ? 'primary' : 
                                            'success'}">
                            ${order.odDeliveryStatus}
                        </span>
                    </td>
                    <td>
                        <button class="btn btn-outline-secondary btn-sm" 
                                onclick="openOrderDetail('${order.oId}')">상세</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- 페이지네이션 -->
<nav class="mt-4">
    <ul class="pagination justify-content-center">
        <c:if test="${pagination.prevPage > 0}">
            <li class="page-item">
                <a class="page-link" href="javascript:void(0)" 
                   onclick="loadOrderList(${pagination.prevPage})">&laquo;</a>
            </li>
        </c:if>
        <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
            <li class="page-item ${i == pagination.page ? 'active' : ''}">
                <a class="page-link" href="javascript:void(0)" 
                   onclick="loadOrderList(${i})">${i}</a>
            </li>
        </c:forEach>
        <c:if test="${pagination.nextPage <= pagination.lastPage}">
            <li class="page-item">
                <a class="page-link" href="javascript:void(0)" 
                   onclick="loadOrderList(${pagination.nextPage})">&raquo;</a>
            </li>
        </c:if>
    </ul>
</nav>

<script>
$(document).ready(function() {
    // 전체 선택 체크박스 이벤트
    $('#checkAll').on('change', function() {
        const isChecked = $(this).prop('checked');
        $('.chkOrder').prop('checked', isChecked);
    });
    
    // 개별 체크박스 이벤트
    $('.chkOrder').on('change', function() {
        const totalCheckboxes = $('.chkOrder').length;
        const checkedCheckboxes = $('.chkOrder:checked').length;
        $('#checkAll').prop('checked', totalCheckboxes === checkedCheckboxes);
    });

    var orderDetailModal = new bootstrap.Modal(document.getElementById('orderDetailModal'));
});

function openOrderDetail(oId) {
    $.ajax({
        url: '/order/admin/detail',
        type: 'GET',
        data: { oId: oId },
        success: function(response) {
            if (response.includes("error")) {
                alert('주문 정보를 불러올 수 없습니다.');
                return;
            }
            $('#orderDetailModal .modal-body').html(response);
            $('#orderDetailModal').modal('show');
        },
        error: function(error) {
            console.error('Error:', error);
            alert('주문 상세 정보를 불러오는 중 오류가 발생했습니다.');
        }
    });
}
</script>
