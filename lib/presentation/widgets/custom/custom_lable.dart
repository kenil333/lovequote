import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class CustomLable extends StatelessWidget {
  final Size size;
  final String title;
  final bool small;
  final bool change;
  final bool dark;
  const CustomLable({
    Key? key,
    required this.size,
    required this.title,
    this.small = false,
    this.change = false,
    this.dark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.045, vertical: 5),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: small ? size.width * 0.04 : size.width * 0.045,
          color: small
              ? grycol
              : change
                  ? Colors.deepOrange
                  : dark
                      ? whit
                      : black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
