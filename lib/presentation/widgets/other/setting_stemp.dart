import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class SettingStemp extends StatelessWidget {
  final Size size;
  final Stream<bool> boolstream;
  final String text;
  final String secondtext;
  final bool initialvalue;
  final Function onclick;
  final bool dark;
  const SettingStemp({
    Key? key,
    required this.size,
    required this.boolstream,
    required this.text,
    required this.secondtext,
    required this.initialvalue,
    required this.onclick,
    required this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    color: dark ? whit : black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  secondtext,
                  style: TextStyle(
                    fontSize: size.width * 0.04,
                    color: dark ? whit.withOpacity(0.5) : grycol,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: size.width * 0.05),
          StreamBuilder<bool>(
            stream: boolstream,
            initialData: initialvalue,
            builder: (context, snap) {
              return Switch(
                value: snap.data!,
                inactiveTrackColor: dark ? whit.withOpacity(0.2) : null,
                onChanged: (bool value) {
                  onclick(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
