import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils/fonts.gen.dart';
import 'screens/navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F3F3F)),
        canvasColor: const Color(0xFF2A2A2A),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        fontFamily: FontFamilyToken.jost,
        useMaterial3: true,
      ),
      home: const NavigationScreen(),
    );
  }
}

