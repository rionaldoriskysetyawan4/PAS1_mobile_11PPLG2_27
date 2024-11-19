import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final String hintText;
  final double radius;
  final Color? colormu;
  final double width;
  final double height;
  final bool? isObsecured;
  final TextEditingController controller; // The controller is directly passed

  const Mytextfield({
    super.key,
    required this.hintText,
    required this.radius,
    this.colormu,
    required this.width,
    required this.height,
    this.isObsecured,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.white,
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: TextField(
          controller: controller,
          obscureText: isObsecured ?? false,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          style: TextStyle(
            color: colormu ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
