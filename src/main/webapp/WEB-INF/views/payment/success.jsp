<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <title>결제 성공</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
      .payment-success {
        max-width: 600px;
        margin: 50px auto;
        padding: 20px;
        text-align: center;
      }
      .success-icon {
        color: #28a745;
        font-size: 48px;
        margin-bottom: 20px;
      }
      .payment-details {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 8px;
        margin: 20px 0;
      }
      .btn-group {
        margin-top: 30px;
      }
    </style>
  </head>
  <body>
    <div class="container payment-success">
      <div class="success-icon">✓</div>
      <h2 class="mb-4">결제가 성공적으로 완료되었습니다</h2>
      
      <div class="payment-details">
        <div class="row mb-3">
          <div class="col-6 text-end fw-bold">결제 번호:</div>
          <div class="col-6 text-start" id="paymentKey"></div>
        </div>
        <div class="row mb-3">
          <div class="col-6 text-end fw-bold">주문 번호:</div>
          <div class="col-6 text-start" id="orderId"></div>
        </div>
        <div class="row">
          <div class="col-6 text-end fw-bold">결제 금액:</div>
          <div class="col-6 text-start" id="amount"></div>
        </div>
      </div>

      <div class="btn-group">
        <a href="/order/list" class="btn btn-primary me-2">주문 내역 보기</a>
        <a href="/userHome" class="btn btn-secondary">쇼핑 계속하기</a>
      </div>
    </div>

    <script>
      // 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
      // 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
      const urlParams = new URLSearchParams(window.location.search);
      const paymentKey = urlParams.get("paymentKey");
      const orderId = urlParams.get("orderId");
      const amount = urlParams.get("amount");

      // 금액 포맷팅 함수
      function formatAmount(amount) {
        return new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(amount);
      }

      document.getElementById("paymentKey").textContent = paymentKey;
      document.getElementById("orderId").textContent = orderId;
      document.getElementById("amount").textContent = formatAmount(amount);

      async function confirm() {
        const requestData = {
          paymentId: paymentKey,
          oId: orderId,
          uId: "${user.uId}",
          amount: parseInt(amount),
          paymentType: "CARD",
          status: "COMPLETED",
          paymentTime: new Date().toISOString()
        };

        const response = await fetch("/payment/confirm", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(requestData),
        });

        const json = await response.json();

        if (!response.ok) {
          // 결제 실패 비즈니스 로직을 구현하세요.
          console.log(json);
          window.location.href = `/payment/fail?message=${json.message}&code=${json.code}`;
        } else {
          window.location.href = `/order/complete?orderId=${orderId}`;
        }

        // 결제 성공 비즈니스 로직을 구현하세요.
        console.log(json);
      }
      confirm();
    </script>
  </body>
</html>