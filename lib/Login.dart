import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'OTP1.dart';
import 'OTP2.dart';
import 'Register.dart';
import 'package:CommuinTel/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_sign_in.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 165.0.h, bottom: 42.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.630,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0)),
                    color: Color(0xffffffff),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(
                                0xff0e5784), // Adjust text color if needed
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            reusableTextField('Phone number', false,
                                Icons.phone, _phoneNumberController),
                            SizedBox(
                              height: 10.h,
                            ),
                            reusableTextField("Email", false,
                                Icons.mail_outline, _emailController),
                            SizedBox(
                              height: 10.h,
                            ),
                            reusableTextField('Password', true, Icons.lock,
                                _passwordController),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: InkWell(
                          onTap: () {
                            if (_passwordController.text != "") {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text)
                                  .then((value) async {
                                String name = '';
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(_emailController.text)
                                    .get()
                                    .then((doc) {
                                  if (doc.exists) {
                                    name = doc.data()?['name'] ?? 'No name';
                                  }
                                });

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            OTPScreen(
                                                email: _emailController.text,
                                                name:
                                                    name)), // Pass the email and name here
                                    (Route<dynamic> route) => false);
                              }).onError((error, stackTrace) {
                                if (kDebugMode) {
                                  print("Error ${error.toString()}");
                                }
                              });
                            }
                          },
                          child: Container(
                              width: 300.w,
                              height: 40.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45,
                                      offset: const Offset(0, 1),
                                      blurRadius: 12.0.r)
                                ],
                                borderRadius: BorderRadius.circular(30.0),
                                color: const Color(0xff0e5784),
                              ),
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                        color: Colors.white), // Adjust text color if needed
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Register()));
                      },
                      child: const Text(
                        'SIGN UP Now',
                        textAlign: TextAlign.end,
                        style: TextStyle(color: Color(0xff0e5784)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
