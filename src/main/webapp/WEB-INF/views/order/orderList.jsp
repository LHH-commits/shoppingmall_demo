<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 주문 목록 테이블 -->
<div class="table-responsive">
    <table class="table table-hover">
        <thead class="table-info">
            <tr>
                <th><input type="checkbox" class="form-check-input" id="checkAll"></th>
                <th>주문일시</th>
                <th>주문번호</th>
                <th>주문인</th>
                <th>주문금액</th>
                <th>배송상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td><input type="checkbox" class="form-check-input chkOrder" value="${order.oId}"></td>
                    <td><fmt:parseDate value="${order.orders.oDatetime}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" />
                    <fmt:formatDate value="${parsedDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    <td>${order.oId}</td>
                    <td>${order.orders.user.uName}</td>
                    <td><fmt:formatNumber value="${order.odPrice}" pattern="#,###"/>원</td>
                    <td>${order.odDeliveryStatus}</td>
                    <td>
                        <button class="btn btn-sm btn-success" onclick="openOrderDetail('${order.oId}')">상세</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- 페이지네이션 -->
<nav>
    <ul class="pagination justify-content-center">
        <c:if test="${pagination.prevPage > 0}">
            <li class="page-item">
                <a class="page-link" href="javascript:void(0)" onclick="loadOrderList(${pagination.prevPage})">&laquo;</a>
            </li>
        </c:if>
        <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}">
            <li class="page-item ${i == pagination.page ? 'active' : ''}">
                <a class="page-link" href="javascript:void(0)" onclick="loadOrderList(${i})">${i}</a>
            </li>
        </c:forEach>
        <c:if test="${pagination.nextPage <= pagination.lastPage}">
            <li class="page-item">
                <a class="page-link" href="javascript:void(0)" onclick="loadOrderList(${pagination.nextPage})">&raquo;</a>
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
