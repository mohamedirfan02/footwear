import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footwearclient/controller/login_cotroller.dart';
import 'package:footwearclient/pages/register_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.network(
                'https://okcredit-blog-images-prod.storage.googleapis.com/2020/12/footwear2.jpg', // Replace with your image URL or use Image.asset() for local assets
                fit: BoxFit.cover,
              ),
            ),
            // Content
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[30]?.withOpacity(0.8), // Optional: Overlay color with opacity
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Welcome Text
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Mobile Number TextField
                    TextField(
                      controller: ctrl.loginNumberCtrl,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.phone_android),
                        labelText: "Mobile Number",
                        hintText: 'Enter your mobile number',
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        ctrl.loginWithPhone();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text('Login'),
                    ),

                    const SizedBox(height: 20),

                    // Register Button
                    TextButton(
                      onPressed: () {
                        Get.to(const RegisterPage());
                      },
                      child: const Text('Register new account'),
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
