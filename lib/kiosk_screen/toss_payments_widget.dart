import 'package:flutter/material.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

class TossPaymentsWidget extends StatefulWidget {
  final List<String> order;

  const TossPaymentsWidget({Key? key, required this.order}) : super(key: key);

  @override
  _TossPaymentsWidgetState createState() => _TossPaymentsWidgetState();
}

class _TossPaymentsWidgetState extends State<TossPaymentsWidget> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;

  @override
  void initState() {
    super.initState();

    _paymentWidget = PaymentWidget(
      clientKey: "YOUR_TOSS_PAYMENTS_CLIENT_KEY",
      customerKey: "YOUR_CUSTOMER_KEY",
    );

    _paymentWidget
        .renderPaymentMethods(
      selector: 'methods',
      amount: Amount(value: 300, currency: Currency.KRW, country: "KR"),
    )
        .then((control) {
      _paymentMethodWidgetControl = control;
    });

    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  PaymentMethodWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'methods',
                  ),
                  AgreementWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'agreement',
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final paymentResult = await _paymentWidget.requestPayment(
                        paymentInfo: PaymentInfo(
                          orderId: 'YOUR_ORDER_ID',
                          orderName: widget.order.join(', '),
                        ),
                      );
                      if (paymentResult.success != null) {
                        // 결제 성공 처리
                        Navigator.pop(context); // 결제 완료 후 화면 닫기
                      }
                    },
                    child: const Text('결제하기'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
