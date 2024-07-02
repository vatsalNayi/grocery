import 'package:flutter/material.dart';
import 'package:grocery_app/core/values/colors.dart';

Widget customDecorationForTextfield({Widget? child, double? borderRadius}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
      color: AppColors.seaShell,
    ),
    // Add other properties or child widgets if needed
    child: child,
  );
}
