<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
  </head>
  <body>
    <h2>결제 성공</h2>
    <p id="paymentKey"></p>
    <p id="orderId"></p>
    <p id="amount"></p>

    <script>
      // 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
      // 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
      const urlParams = new URLSearchParams(window.location.search);
      const paymentKey = urlParams.get("paymentKey");
      const orderId = urlParams.get("orderId");
      const amount = urlParams.get("amount");

      async function confirm() {
        const requestData = {
          paymentId: paymentKey,
          oId: parseInt(orderId),
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
          window.location.href = '/order/complete';
        }

        // 결제 성공 비즈니스 로직을 구현하세요.
        console.log(json);
      }
      confirm();

      const paymentKeyElement = document.getElementById("paymentKey");
      const orderIdElement = document.getElementById("orderId");
      const amountElement = document.getElementById("amount");

      orderIdElement.textContent = "주문번호: " + orderId;
      amountElement.textContent = "결제 금액: " + amount;
      paymentKeyElement.textContent = "paymentKey: " + paymentKey;
    </script>
  </body>
</html>