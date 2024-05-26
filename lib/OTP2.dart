import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'OTP3.dart';
import 'home page.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final String name;

  const OTPVerificationScreen(
      {super.key, required this.email, required this.name});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onOtpEntered() {
    String otp = _controllers.map((controller) => controller.text).join();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const OTPDone()),
    );
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                HomePage(email: widget.email, name: widget.name)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffe2eff7),
        leading: BackButton(
          color: const Color(0xFF0E5784),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 40.w),
          child: const Text('OTP Verification',
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF0E5784),
              ),
              textAlign: TextAlign.center),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xffe2eff7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              const Text(
                'Enter 4 digit verification code sent\n to your phone number',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF0E5784),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: SizedBox(
                      width: 50.w,
                      height: 50.h,
                      child: TextField(
                        controller: _controllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1 && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (index == 3 && value.length == 1) {
                            _onOtpEntered();
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.0.h),
              GestureDetector(
                onTap: () {
                  // Handle "Send Code" action
                  if (kDebugMode) {
                    print('Send Code tapped');
                  }
                },
                child: const Text(
                  'Send Code',
                  style: TextStyle(
                    color: Color(0xFF0E5784),
                    fontSize: 18.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
