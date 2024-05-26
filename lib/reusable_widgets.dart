import 'package:flutter/material.dart';

TextField reusableTextField(String name, bool isPassword, IconData iconShape,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    // keyboardType: TextInputType.visiblePassword,
    obscureText: isPassword,
    decoration: InputDecoration(
        labelText: name,
        labelStyle: const TextStyle(color: Colors.black),
        border: const UnderlineInputBorder(),
        prefixIcon: Icon(
          iconShape,
          color: Colors.black,
        ),
        ),
  );
}


