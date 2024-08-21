import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footwearclient/controller/login_cotroller.dart';
import 'package:footwearclient/pages/login_page.dart';
import 'package:footwearclient/pages/widgets/otp_txt_field.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.network(
                'https://static.toiimg.com/thumb/msid-109597929,width-400,resizemode-4/109597929.jpg', // Replace with your image URL or use Image.asset() for local assets
                fit: BoxFit.cover, // Ensures the image covers the entire background
              ),
            ),
            // Optional overlay for readability
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.blueGrey[30]?.withOpacity(0.8), // Optional: Dim the background image
                ),
              ),
            ),
            // Content
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50]?.withOpacity(0.8), // Optional: Additional overlay for better readability
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Page Title
                    const Text(
                      'Create Your Account !!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name TextField
                    TextField(
                      keyboardType: TextInputType.text,
                      controller: ctrl.registerNameCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Your Name',
                        hintText: 'Enter Your Name',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Mobile Number TextField
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: ctrl.registerNumberCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.phone_android),
                        labelText: 'Mobile Number',
                        hintText: 'Enter Your Mobile Number',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // OTP TextField
                    OtpTextField(
                      otpController: ctrl.otpController,
                      visble: ctrl.otpFieldShow,
                      onComplete: (otp) {
                        ctrl.otpEnter = int.tryParse(otp ?? '0000');
                      },
                    ),
                    const SizedBox(height: 20),

                    // Register/Send OTP Button
                    ElevatedButton(
                      onPressed: () {
                        if (ctrl.otpFieldShow) {
                          ctrl.addUser();
                        } else {
                          ctrl.sendOtp();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: Text(ctrl.otpFieldShow ? 'Register' : 'Send OTP'),
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    TextButton(
                      onPressed: () {
                        Get.to(const LoginPage());
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
