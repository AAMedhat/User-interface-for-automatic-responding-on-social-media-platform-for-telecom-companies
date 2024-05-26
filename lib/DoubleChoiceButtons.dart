import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoubleChoiceButtons extends StatefulWidget {
  final Function(String) onSelectionChanged;

  const DoubleChoiceButtons({super.key, required this.onSelectionChanged});

  @override
  _DoubleChoiceButtonsState createState() => _DoubleChoiceButtonsState();
}

class _DoubleChoiceButtonsState extends State<DoubleChoiceButtons> {
  final List<bool> _selections = [true, false];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 330.w,
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                offset: const Offset(0, 1),
                blurRadius: 12.0.r)
          ],
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xff0e5784),
        ),
        child: ToggleButtons(
          borderRadius: BorderRadius.circular(10),
          fillColor: Colors.white,
          selectedColor: Colors.black,
          color: Colors.white,
          isSelected: _selections,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _selections.length; i++) {
                _selections[i] = i == index;
              }
              String userType = index == 0 ? 'Customer' : 'Admin';
              widget.onSelectionChanged(userType);
            });
          },
          children: [
            SizedBox(
                width: 162.w,
                child: const Text('Customer', textAlign: TextAlign.center)),
            SizedBox(
                width: 162.w,
                child: const Text('Admin', textAlign: TextAlign.center)),
          ],
        ),
      ),
    );
  }
}
