import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footwearclient/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // Hides system UI for an immersive experience.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Navigates to the LoginPage after a delay of 5 seconds.
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    // Restores the system UI overlays when the widget is disposed.
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Ensures the container takes up full width.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.pink], // Background gradient colors.
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers the children vertically.
          children: [
            // Text widget to display the 'Welcome' message.
            const Text(
              '𝓕𝓸𝓸𝓽𝓦𝓮𝓪𝓻 𝓢𝓽𝓸𝓻𝓮',
              style: TextStyle(
                color: Colors.white, // Single color for the text.
                fontSize: 45, // Font size for the text.
              ),
            ),
            const SizedBox(height: 20), // Adds space between the text and image.

            // Image widget to load an image from the network.
            Container(
              width: 250, // Sets the width of the image.
              height: 250, // Sets the height of the image.
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Rounded corners for the image.
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://i.pinimg.com/236x/62/75/48/627548c3d72db80eb6555a2edd0700d9.jpg',
                  ),
                  fit: BoxFit.cover, // Ensures the image covers the container.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
