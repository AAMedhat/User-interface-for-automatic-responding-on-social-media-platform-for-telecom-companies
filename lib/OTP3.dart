import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPDone extends StatefulWidget {
  const OTPDone({super.key});

  @override
  _OTPDone createState() => _OTPDone();
}

class _OTPDone extends State<OTPDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      color: const Color(0xffe2eff7),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200.w,
            height: 200.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Done.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            'Phone Number Verified',
            style: TextStyle(
              fontSize: 25.0,
              color: Color(0xFF0E5784),
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'You will be redirected to the main page\n in a few moments',
            style: TextStyle(
              fontSize: 15.0,
              color: Color(0xFF0E5784),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }
}
