import 'package:CommuinTel/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Login.dart';
import 'SearchPlates.dart';
import 'DoubleChoiceButtons.dart'; // Ensure this import is correct

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String userType = 'Customer'; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_sign_up.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 70.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
                  child: Text(
                    'Create\nAccount',
                    style: TextStyle(
                        color: const Color(0xff0e5784),
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DoubleChoiceButtons(
                      onSelectionChanged: (String selectedUserType) {
                        setState(() {
                          userType = selectedUserType;
                        });
                        if (kDebugMode) {
                          print('Selected User Type: $userType');
                        } // Print statement
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          reusableTextField("Full name", false,
                              Icons.person_outline, _fullNameController),
                          reusableTextField("Email", false, Icons.mail_outline,
                              _emailController),
                          reusableTextField('Phone number', false,
                              Icons.phone_outlined, _phoneNumberController),
                          reusableTextField('Password', true,
                              Icons.lock_outline, _passwordController),
                          reusableTextField('Confirm password', true,
                              Icons.lock_outline, _confirmPasswordController),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: InkWell(
                        onTap: () {
                          if (_passwordController.text ==
                              _confirmPasswordController.text) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((value) {
                              if (kDebugMode) {
                                print("Created New account successfully");
                              }
                              final name = _fullNameController.text;
                              final email = _emailController.text;
                              final phone = _phoneNumberController.text;

                              createUser(
                                name: name,
                                email: email,
                                phone: phone,
                                userType: userType,
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const Searchplates()),
                                  (Route<dynamic> route) => false);
                            }).onError((error, stackTrace) {
                              if (kDebugMode) {
                                print("Error ${error.toString()}");
                              }
                            });
                          } else {
                            if (kDebugMode) {
                              print("Enter correct password");
                            }
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
                              'SIGN UP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Login()));
                            },
                            child: const Text(
                              'SIGN IN',
                              style: TextStyle(color: Color(0xff0e5784)),
                            ))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future createUser({
    required String name,
    required String phone,
    required String email,
    required String userType,
  }) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(email);
    final json = {
      'name': name,
      'phone': phone,
      'email': email,
      'userType': userType,
    };
    await docUser.set(json);
  }
}
