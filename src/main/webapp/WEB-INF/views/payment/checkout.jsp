<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <script src="https://js.tosspayments.com/v2/standard"></script>
  </head>
  <body>
    <!-- 결제 UI -->
    <div id="payment-method"></div>
    <!-- 이용약관 UI -->
    <div id="agreement"></div>
    <!-- 결제하기 버튼 -->
    <button class="button" id="payment-button" style="margin-top: 30px">결제하기</button>

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