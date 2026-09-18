import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'screens/welcome_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const VivaktiApp());
}

class VivaktiApp extends StatelessWidget {
  const VivaktiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'Vivakti',
      debugShowCheckedModeBanner: false,
      theme: neumorphicThemeData,
      home: const WelcomeScreen(),
    );
  }
}
