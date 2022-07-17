import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:tic_tac_game/home_screen.dart';
import 'package:splash_screen_view/splash_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF00061a),
        shadowColor: const Color(0xFF001456),
        splashColor: const Color(0xFF4169e8),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(
        navigateRoute: const HomePage(),
        duration: 3000,
        imageSize: 200,
        imageSrc: "assets/images/X&O_splash.png",
        backgroundColor: const Color(0xFF00061a),
      ),
    );
  }
}
