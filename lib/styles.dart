import 'package:flutter/material.dart';
import 'package:heloderma/colors.dart';

const TextStyle H1 = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w700,
  color: darkBlue,
);

const TextStyle H2 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
const TextStyle H3 = const TextStyle(fontSize: 16, fontWeight: FontWeight.w700);

const ButtonStyle blueButtonStyle = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll<Color>(darkBlue),
  padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
    EdgeInsets.symmetric(vertical: 24),
  ),
  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
  ),
);
