<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <style>
      /* 결제 버튼 스타일링 */
      #payment-button {
        width: 100%;
        padding: 15px;
        background-color: #0064FF;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s ease;
      }

      #payment-button:hover {
        background-color: #0052CC;
      }

      #payment-button:active {
        background-color: #0047B3;
      }

      /* 결제 UI 컨테이너 스타일 */
      .payment-container {
        max-width: 800px;
        margin: 40px auto;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 12px;
      }

      #payment-method, #agreement {
        margin-bottom: 20px;
      }
    </style>
  </head>
  <body>
    <div class="payment-container">
      <!-- 결제 UI -->
      <div id="payment-method"></div>
      <!-- 이용약관 UI -->
      <div id="agreement"></div>
      <!-- 결제하기 버튼 -->
      <button id="payment-button">결제하기</button>
    </div>

    <script>
      main();

      async function main() {
        const button = document.getElementById("payment-button");
        
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        
        // 회원 결제 - 실제 로그인한 사용자의 ID를 customerKey로 사용
        const customerKey = "${user.uId}";
        const widgets = tossPayments.widgets({
          customerKey,
        });

        // 실제 주문 금액 설정
        await widgets.setAmount({
          currency: "KRW",
          value: Number(${totalPrice})
        });

        await Promise.all([
          widgets.renderPaymentMethods({
            selector: "#payment-method",
            variantKey: "DEFAULT",
          }),
          widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);

        button.addEventListener("click", async function () {
          await widgets.requestPayment({
            orderId: "${orders.oId}",
            orderName: "${orderDetail.product.pName}",
            successUrl: "http://43.202.200.176:8080/payment/success",
            failUrl: "http://43.202.200.176:8080/payment/fail",
            customerEmail: "${user.uId}",
            customerName: "${user.uName}",
            customerMobilePhone: "${user.uPhone}",
          });
        });
      }
    </script>
  </body>
</html>