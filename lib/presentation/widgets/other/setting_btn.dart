import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class SettingButton extends StatelessWidget {
  final Size size;
  final String title;
  final String secondtext;
  final Function onclick;
  final bool dark;
  const SettingButton({
    Key? key,
    required this.size,
    required this.title,
    this.secondtext = "null",
    required this.onclick,
    required this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onclick();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: dark ? whit : black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            secondtext != "null"
                ? Text(
                    secondtext,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: dark ? whit.withOpacity(0.5) : grycol,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
