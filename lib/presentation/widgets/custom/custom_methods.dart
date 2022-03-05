import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

appbarpref(bool dark, Color color) {
  return PreferredSize(
    child: AppBar(
      backgroundColor: color,
      systemOverlayStyle:
          dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      elevation: 0,
    ),
    preferredSize: const Size.fromHeight(0),
  );
}

routepushreplash(BuildContext context, Widget widget) {
  return Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

routepush(BuildContext context, Widget widget) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

prefsetbool(String key, bool value) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setBool(key, value);
}

prefsetdouble(String key, double value) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setDouble(key, value);
}
