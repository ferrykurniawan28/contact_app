import 'package:contact/presentations/splash/controllers/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller;
    return const Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Center(
        child: ImageIcon(
          AssetImage('assets/images/contact-book.png'),
          size: 100,
        ),
      ),
    );
  }
}
