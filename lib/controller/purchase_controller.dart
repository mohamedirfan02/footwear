// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class PurchaseController extends GetxController {
//   TextEditingController addressController = TextEditingController();
//
//   double orderPrice = 0;
//   String itemName = "";
//   String orderAddress = '';
//
//   submitOrder(
//       {required double price,
//       required String item,
//       required String description}) {
//     orderPrice = price;
//     itemName = item;
//     orderAddress = addressController.text;
//
//     Razorpay razorpay = Razorpay();
//     var options = {
//       'key': 'rzp_test_gtcNTi9mqwQ7r4',
//       'amount': price *100,
//       'name': item,
//       'description': description,
//     };
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//
//   }
// }
