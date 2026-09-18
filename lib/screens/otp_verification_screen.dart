import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:vivakti_app/utils/constants.dart';
import 'package:vivakti_app/screens/category_selection_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  bool _isLoading = false;
  int _resendTimer = 30;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), _startResendTimer);
  }

  void _startResendTimer() {
    if (!mounted) return;
    if (_resendTimer > 0) {
      setState(() {
        _resendTimer--;
      });
      Future.delayed(const Duration(seconds: 1), _startResendTimer);
    }
  }

  void _verifyOtp() {
    bool isValid = true;
    for (var controller in _otpControllers) {
      if (controller.text.isEmpty) {
        isValid = false;
        break;
      }
    }

    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all OTP digits")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Replace with a real call to POST /auth/verify-otp
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CategorySelectionScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Back button
            Align(
              alignment: Alignment.topLeft,
              child: NeumorphicButton(
                onPressed: () => Navigator.pop(context),
                style: NeumorphicStyle(
                  color: Colors.white,
                  depth: 4,
                  intensity: 0.5,
                  shape: NeumorphicShape.convex,
                ),
                child: const Icon(Icons.arrow_back, size: 20),
              ),
            ),

            const SizedBox(height: 40),

            // Title
            const Text(
              "Verify your phone number",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Constants.textColor,
              ),
            ),

            const SizedBox(height: 10),

            // Phone number
            Text(
              widget.phoneNumber,
              style: TextStyle(
                fontSize: 18,
                color: Constants.textColor.withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 30),

            // OTP input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: TextField(
                    controller: _otpControllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: const EdgeInsets.all(0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Constants.textColor.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Constants.primaryColor,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 30),

            // Verify button
            NeumorphicButton(
              onPressed: _isLoading ? null : _verifyOtp,
              style: NeumorphicStyle(
                color: Constants.primaryColor,
                depth: 8,
                intensity: 0.8,
                shape: NeumorphicShape.convex,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        "Verify OTP",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // Resend OTP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't receive OTP? "),
                if (_resendTimer > 0)
                  Text(
                    "Resend in $_resendTimer seconds",
                    style: const TextStyle(color: Colors.grey),
                  )
                else
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _resendTimer = 30;
                      });
                      _startResendTimer();
                    },
                    child: const Text(
                      "Resend OTP",
                      style: TextStyle(color: Constants.primaryColor, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
