import 'package:flutter/material.dart';

import './../../domain/all.dart';

BoxDecoration containerdeco(bool dark) {
  return BoxDecoration(
    color: dark ? darkcontainer : whit,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 10),
        blurRadius: 20,
        color: dark ? black87 : grycol.withOpacity(0.4),
      ),
    ],
  );
}

TextStyle whitetext(double size) {
  return TextStyle(
    fontSize: size,
    color: whit,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
    shadows: const [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 1.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 1.0,
        color: Color.fromARGB(125, 0, 0, 255),
      ),
    ],
  );
}

DecorationImage backimage(ImageProvider image) {
  return DecorationImage(
    colorFilter: ColorFilter.mode(
      Colors.black.withOpacity(0.20),
      BlendMode.darken,
    ),
    image: image,
    fit: BoxFit.cover,
  );
}
