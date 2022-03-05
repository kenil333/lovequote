import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class SettingSlider extends StatelessWidget {
  final Size size;
  final double mainvariable;
  final String title;
  final Function onchange;
  final bool fontsize;
  final bool dark;
  const SettingSlider({
    Key? key,
    required this.size,
    required this.mainvariable,
    required this.title,
    required this.onchange,
    this.fontsize = false,
    required this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              title,
              style: TextStyle(
                fontSize: size.width * 0.045,
                color: dark ? whit : black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 0),
          Slider(
            value: mainvariable,
            min: fontsize ? 15.0 : 0.0,
            max: fontsize ? 25.0 : 2.0,
            divisions: fontsize ? 10 : 20,
            onChanged: (double value) {
              onchange(value);
            },
          ),
        ],
      ),
    );
  }
}
