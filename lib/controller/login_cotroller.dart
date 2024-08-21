import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footwearclient/model/user/user.dart';
import 'package:footwearclient/pages/home_page.dart';
import 'package:footwearclient/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {

  GetStorage box = GetStorage();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNameCtrl = TextEditingController();

  TextEditingController registerNumberCtrl = TextEditingController();
  TextEditingController loginNumberCtrl = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();

  bool otpFieldShow = false;
  int? otpSent;
  int? otpEnter;

  User? loginUser;

  @override
  void onReady() {
   Map<String,dynamic>? user = box.read('loginUser');
   if(user != null){
      loginUser = User.fromJson(user);
     Get.to(const HomePage());
   }
    super.onReady();
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (otpSent == otpEnter) {
        DocumentReference doc = userCollection.doc();
        User user = User(
          id: doc.id,
          name: registerNameCtrl.text,
          number: int.parse(registerNumberCtrl.text),
        );
        final userJson = user.toJson();
        doc.set(userJson);
        Get.snackbar("Success", "User added Successfully",
            colorText: Colors.green);
        registerNumberCtrl.clear();
        registerNameCtrl.clear();
        otpController.clear();
      } else {
        Get.snackbar("Error", "OTP is incorrect", colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), colorText: Colors.green);
      print(e);
    }
  }

  sendOtp() {
    try {
      if (registerNameCtrl.text.isEmpty || registerNumberCtrl.text.isEmpty) {
        Get.snackbar("Error", "Please fill the Field", colorText: Colors.red);
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      print(otp);
      if (otp != null) {
        otpFieldShow = true;
        otpSent = otp;
        Get.snackbar('Success', 'otp send Successfully !!',
            colorText: Colors.green);
      } else {
        Get.snackbar('Error', 'otp not send !!', colorText: Colors.red);
      }
    } catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  Future<void> loginWithPhone() async {
    try {
      String phoneNumber = loginNumberCtrl.text;
      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('number', isEqualTo: int.tryParse(phoneNumber) )
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var userData = userDoc.data() as Map<String, dynamic>;
          box.write('loginUser', userData);
          loginNumberCtrl.clear();
          Get.to(const HomePage());
          Get.snackbar('success', 'Login Successful', colorText: Colors.green);
        } else {
          Get.snackbar('Error', 'User not found, please Register',
              colorText: Colors.red);
        }
      }
    } catch (error) {
      print('Field to Login');
    }
  }
}
