import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footwearclient/controller/home_controller.dart';
import 'package:footwearclient/controller/login_cotroller.dart';
import 'package:footwearclient/pages/register_page.dart';
import 'package:footwearclient/pages/widgets/splashScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(LoginController());
  Get.put(HomeController());
  // Get.put(const SplashScreen());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
    );
  }
}

