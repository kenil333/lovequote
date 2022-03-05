import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class ReminderWidget extends StatelessWidget {
  final Size size;
  final String title;
  final bool initialbool;
  final bool dark;
  final Function onclick;
  final Function editfunc;
  final Function deletefunc;
  const ReminderWidget({
    Key? key,
    required this.size,
    required this.title,
    required this.initialbool,
    required this.dark,
    required this.onclick,
    required this.editfunc,
    required this.deletefunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: 10,
      ),
      padding: EdgeInsets.only(
        left: size.width * 0.05,
        right: size.width * 0.03,
        top: 15,
        bottom: 15,
      ),
      decoration: containerdeco(dark),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: size.width * 0.05,
              color: dark ? whit : black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(child: Container()),
          Switch(
            value: initialbool,
            inactiveTrackColor: dark ? whit.withOpacity(0.2) : null,
            onChanged: (bool value) {
              onclick(value);
            },
          ),
          SizedBox(width: size.width * 0.01),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_horiz_rounded,
              color: dark ? whit : black87,
            ),
            color: dark ? black87 : whit,
            onSelected: (String value) async {
              if (value == "Edit") {
                editfunc();
              } else {
                deletefunc();
              }
            },
            itemBuilder: (BuildContext context) {
              return {"Edit", "Delete"}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(
                    choice,
                    style: TextStyle(color: dark ? whit : black87),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}
