import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../../domain/all.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _control = Get.put(GlobalCache());
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then(
      (_) async {
        final SharedPreferences _prefs = await SharedPreferences.getInstance();
        final bool _dataset = _prefs.getBool("SetData") ?? false;
        final bool _setnotification =
            _prefs.getBool("SetNotification") ?? false;
        if (_dataset == false) {
          await _prefs.setBool("Vibrate", true);
          await _prefs.setBool("DarkMode", false);
          await _prefs.setBool("PlainBackground", false);
          await _prefs.setBool("LocalNotification", true);
          // await _prefs.setBool("PictureNotification", true);
          // await _prefs.setBool("VideoNotification", true);
          // await _prefs.setBool("RemoteNotification", true);
          // await _prefs.setBool("ArticleNotification", true);
          await _prefs.setDouble("SpeechRate", 1.1);
          await _prefs.setDouble("Pitch", 1.1);
          await _prefs.setDouble("ArticleFont", 15.0);
          for (int i = 0; i < notificationlist.length; i++) {
            await NotificationDbHelper.insert(
              {
                "id": notificationlist[i].id.toString(),
                "hour": notificationlist[i].hour,
                "minute": notificationlist[i].minute,
                "ampm": notificationlist[i].ampm,
                "active": notificationlist[i].active.toString(),
              },
            );
          }
          await _prefs.setBool("SetData", true);
          List<NotificationModel> _notificationlist = [];
          final _notifications = await NotificationDbHelper.getData();
          _notificationlist = _notifications
              .map(
                (e) => NotificationModel(
                  id: int.parse(e["id"]),
                  hour: e["hour"],
                  minute: e["minute"],
                  ampm: e["ampm"],
                  active: e["active"] == "true" ? true : false,
                ),
              )
              .toList();
          for (int i = 0; i < _notificationlist.length; i++) {
            if (_notificationlist[i].active) {
              await NotificationService().schedulenotification(
                _notificationlist[i].id,
                "Quote of the Day",
                "${_control.todayquoterx.value}\n\n- Click to open the app for new quotes.",
                _notificationlist[i].hour,
                _notificationlist[i].minute,
                _notificationlist[i].ampm,
              );
            }
          }
          await _prefs.setBool("SetNotification", true);
        } else {
          if (_setnotification == false) {
            List<NotificationModel> _notificationlist = [];
            final _notifications = await NotificationDbHelper.getData();
            _notificationlist = _notifications
                .map(
                  (e) => NotificationModel(
                    id: int.parse(e["id"]),
                    hour: e["hour"],
                    minute: e["minute"],
                    ampm: e["ampm"],
                    active: e["active"] == "true" ? true : false,
                  ),
                )
                .toList();
            for (int i = 0; i < _notificationlist.length; i++) {
              if (_notificationlist[i].active) {
                await NotificationService().schedulenotification(
                  _notificationlist[i].id,
                  "Quote of the Day",
                  "${_control.todayquoterx.value}\n\n- Click to open the app for new quotes.",
                  _notificationlist[i].hour,
                  _notificationlist[i].minute,
                  _notificationlist[i].ampm,
                );
              }
            }
            await _prefs.setBool("SetNotification", true);
          }
        }
        _control.fetchfavmess();
        _control.fetchfavpic();
        // Future.delayed(const Duration(milliseconds: 500)).then(
        //   (_) {
        final bool _vibrate = _prefs.getBool("Vibrate") ?? false;
        final bool _darkmode = _prefs.getBool("DarkMode") ?? false;
        final bool _plainback = _prefs.getBool("PlainBackground") ?? false;
        final bool _localnotification =
            _prefs.getBool("LocalNotification") ?? false;
        // final bool _picturenoti =
        //     _prefs.getBool("PictureNotification") ?? false;
        // final bool _vidnotification =
        //     _prefs.getBool("VideoNotification") ?? false;
        // final bool _remotenotification =
        //     _prefs.getBool("RemoteNotification") ?? false;
        // final bool _articlenotification =
        //     _prefs.getBool("ArticleNotification") ?? false;
        final double _speech = _prefs.getDouble("SpeechRate") ?? 1.1;
        final double _pit = _prefs.getDouble("Pitch") ?? 1.1;
        final double _font = _prefs.getDouble("ArticleFont") ?? 15.0;

        _control.vibratechange(_vibrate);
        _control.darkmodechange(_darkmode);
        _control.plainbackchange(_plainback);
        _control.localnotichange(_localnotification);
        // _control.picnotichange(_picturenoti);
        // _control.vidnotichange(_vidnotification);
        // _control.remotnotichange(_remotenotification);
        // _control.articlenotichange(_articlenotification);
        _control.speeechratchange(_speech);
        _control.pitchchange(_pit);
        _control.articlefontchange(_font);
        _control.picquotechange(await FirebaseHelper().getpicquotes());
        _control.articlechange(await FirebaseHelper().getarticles());
        _control.quoteschange(await FirebaseHelper().getquotes());
        _control.imageschange(await FirebaseHelper().getimages());
        _control.todayquotechange(await FirebaseHelper().gettodayquote());
        routepushreplash(context, const HomeScreen());
      },
    );
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            // stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              linerarstart,
              linerend,
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            appiconimg,
            fit: BoxFit.contain,
            width: size.width * 0.6,
          ),
        ),
      ),
    );
  }
}
