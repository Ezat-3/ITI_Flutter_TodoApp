import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;
  final Function()? onPressed;
  final Color colorText;
  final BoxBorder? border;
  const CustomIconButton(
      {super.key,
      this.width = 350,
      this.height = 60,
      required this.color,
      required this.text,
      this.onPressed,
      this.colorText = Colors.white,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: border,
        color: color,
        borderRadius: BorderRadius.circular(19),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: colorText,
          ),
        ),
      ),
    );
  }
}
