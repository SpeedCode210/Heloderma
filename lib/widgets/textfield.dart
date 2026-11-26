import 'package:flutter/material.dart';

Widget helodermaTextField({
  required String title,
  String? hintText,
  void Function(String)? onChanged,
  String? Function(String?)? validator,
  TextInputType? keyboardType, 
  int maxLines = 1,
  TextEditingController? controller
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ),
      TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
          ), // Lighter grey hint text
        ),
      ),
    ],
  );
}
