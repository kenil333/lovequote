import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class DrawerButton extends StatelessWidget {
  final Size size;
  final String title;
  final String image;
  final Function onclick;
  final bool color;
  final bool dark;
  const DrawerButton({
    Key? key,
    required this.size,
    required this.title,
    required this.image,
    required this.onclick,
    this.color = false,
    required this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onclick();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: 15,
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: size.width * 0.075,
              fit: BoxFit.contain,
              color: color ? Colors.black54 : null,
            ),
            SizedBox(width: size.width * 0.05),
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: dark ? whit : black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
