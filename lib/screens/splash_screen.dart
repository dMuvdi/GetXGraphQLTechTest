import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SplashController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color(0xFF3F3F3F),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/rick_and_morty_logo.png', width: 400),
                  const SizedBox(height: 15,),
                  const LinearProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Color(0xFF2A2A2A),
                  )
                ],
              )
            ),
          ),
        );
      }
    );
  }
}