import 'package:flutter/material.dart';

import './../../../domain/all.dart';

class GridStempWidget extends StatelessWidget {
  final Size size;
  final String title;
  final String image;
  final Function onclick;
  final bool dark;
  const GridStempWidget({
    Key? key,
    required this.size,
    required this.title,
    required this.image,
    required this.onclick,
    required this.dark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onclick();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: size.width * 0.038,
                color: dark ? whit : black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
