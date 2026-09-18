import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vivakti_app/utils/constants.dart';
import 'package:vivakti_app/screens/phone_entry_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Constants.backgroundColor,
              Colors.white.withOpacity(0.9),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                margin: const EdgeInsets.all(30),
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Constants.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.home_repair_service,
                  size: 80,
                  color: Colors.white,
                ),
              ),

              // Title
              Text(
                Constants.appName,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Constants.textColor,
                ),
              ),

              const SizedBox(height: 20),

              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "Find the right service provider for your needs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Constants.textColor,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Get Started Button
              NeumorphicButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PhoneEntryScreen()),
                  );
                },
                style: NeumorphicStyle(
                  color: Constants.primaryColor,
                  depth: 8,
                  intensity: 0.8,
                  shape: NeumorphicShape.convex,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
