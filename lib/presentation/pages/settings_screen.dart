import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailto/mailto.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import './../../domain/all.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalCache _control = Get.find();
  final _vibrate = BoolStream();
  final _darkmode = BoolStream();
  final _plainback = BoolStream();
  final _localnotification = BoolStream();
  // final _picnotification = BoolStream();
  // final _videonotification = BoolStream();
  // final _remotenotification = BoolStream();
  // final _articlenotification = BoolStream();
  final _speechrate = DoubleStream();
  final _pitch = DoubleStream();
  final _fontsize = DoubleStream();

  @override
  void dispose() {
    _vibrate.dispose();
    _darkmode.dispose();
    _plainback.dispose();
    _localnotification.dispose();
    // _picnotification.dispose();
    // _videonotification.dispose();
    // _remotenotification.dispose();
    // _articlenotification.dispose();
    _speechrate.dispose();
    _pitch.dispose();
    _fontsize.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: _control.darkmoderx.value ? screenbackdark : whit,
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: _control.darkmoderx.value ? whit : black87,
          ),
          backgroundColor: _control.darkmoderx.value ? appbardark : whit,
          title: Text(
            "Settings",
            style: TextStyle(
              letterSpacing: 1.5,
              color: _control.darkmoderx.value ? whit : black87,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomLable(
                size: size,
                title: "General",
                change: true,
              ),
              const SizedBox(height: 15),
              SettingStemp(
                size: size,
                boolstream: _vibrate.stream,
                text: "Vibrate",
                secondtext: "Vibrate on key press",
                initialvalue: _control.vibraterx.value,
                onclick: (bool value) {
                  _control.vibrateclick();
                  prefsetbool("Vibrate", value);
                  _control.vibratechange(value);
                  _vibrate.sink.add(value);
                },
                dark: _control.darkmoderx.value,
              ),
              const SizedBox(height: 15),
              SettingStemp(
                size: size,
                boolstream: _darkmode.stream,
                text: "User dark theme",
                secondtext: "Get that whiteness out of my sight",
                initialvalue: _control.darkmoderx.value,
                onclick: (bool value) {
                  _control.vibrateclick();
                  prefsetbool("DarkMode", value);
                  _control.darkmodechange(value);
                  _darkmode.sink.add(value);
                },
                dark: _control.darkmoderx.value,
              ),
              const SizedBox(height: 15),
              SettingStemp(
                size: size,
                boolstream: _plainback.stream,
                text: "Plain background",
                secondtext: "Use Plain gradient background",
                initialvalue: _control.plainbackrx.value,
                onclick: (bool value) {
                  _control.vibrateclick();
                  prefsetbool("PlainBackground", value);
                  _control.plainbackchange(value);
                  _plainback.sink.add(value);
                },
                dark: _control.darkmoderx.value,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: grycol.withOpacity(0.6),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              const SizedBox(height: 10),
              CustomLable(
                size: size,
                title: "Notifications",
                change: true,
              ),
              const SizedBox(height: 15),
              SettingStemp(
                size: size,
                boolstream: _localnotification.stream,
                text: "Enable local notifications",
                secondtext:
                    "Receive a daily local notification at a specific time",
                initialvalue: _control.localnotirx.value,
                onclick: (bool value) async {
                  _control.vibrateclick();
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
                  if (value) {
                    for (int i = 0; i < _notificationlist.length; i++) {
                      if (_notificationlist[i].active) {
                        NotificationService().schedulenotification(
                          _notificationlist[i].id,
                          "Quote of the Day",
                          "${_control.todayquoterx.value}\n\n- Click to open the app for new quotes.",
                          _notificationlist[i].hour,
                          _notificationlist[i].minute,
                          _notificationlist[i].ampm,
                        );
                      }
                    }
                  } else {
                    for (int i = 0; i < _notificationlist.length; i++) {
                      if (_notificationlist[i].active) {
                        NotificationService().canclenotification(
                          _notificationlist[i].id,
                        );
                      }
                    }
                  }
                  prefsetbool("LocalNotification", value);
                  _control.localnotichange(value);
                  _localnotification.sink.add(value);
                },
                dark: _control.darkmoderx.value,
              ),
              const SizedBox(height: 5),
              SettingButton(
                size: size,
                title: "Set reminder time",
                secondtext: "08:00 AM, 08:00 PM",
                onclick: () {
                  _control.vibrateclick();
                  routepush(context, const SetReminderScreen());
                },
                dark: _control.darkmoderx.value,
              ),
              const SizedBox(height: 5),
              // SettingStemp(
              //   size: size,
              //   boolstream: _picnotification.stream,
              //   text: "Enable picture notifications",
              //   secondtext: "Receive picture notifications",
              //   initialvalue: _control.picnotirx.value,
              //   onclick: (bool value) {
              //     _control.vibrateclick();
              //     prefsetbool("PictureNotification", value);
              //     _control.picnotichange(value);
              //     _picnotification.sink.add(value);
              //   },
              //   dark: _control.darkmoderx.value,
              // ),
              // const SizedBox(height: 15),
              // SettingStemp(
              //   size: size,
              //   boolstream: _videonotification.stream,
              //   text: "Enable video notifications",
              //   secondtext: "Receive video notifications",
              //   initialvalue: _control.vidnotirx.value,
              //   onclick: (bool value) {
              //     _control.vibrateclick();
              //     prefsetbool("VideoNotification", value);
              //     _control.vidnotichange(value);
              //     _videonotification.sink.add(value);
              //   },
              //   dark: _control.darkmoderx.value,
              // ),
              // const SizedBox(height: 15),
              // SettingStemp(
              //   size: size,
              //   boolstream: _remotenotification.stream,
              //   text: "Enable remote notifications",
              //   secondtext: "Receive remote notifications",
              //   initialvalue: _control.remonotirx.value,
              //   onclick: (bool value) {
              //     _control.vibrateclick();
              //     prefsetbool("RemoteNotification", value);
              //     _control.remotnotichange(value);
              //     _remotenotification.sink.add(value);
              //   },
              //   dark: _control.darkmoderx.value,
              // ),
              // const SizedBox(height: 15),
              // SettingStemp(
              //   size: size,
              //   boolstream: _articlenotification.stream,
              //   text: "Enable article notifications",
              //   secondtext: "Receive article notifications",
              //   initialvalue: _control.artinotirx.value,
              //   onclick: (bool value) {
              //     _control.vibrateclick();
              //     prefsetbool("ArticleNotification", value);
              //     _control.articlenotichange(value);
              //     _articlenotification.sink.add(value);
              //   },
              //   dark: _control.darkmoderx.value,
              // ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: grycol.withOpacity(0.6),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              const SizedBox(height: 10),
              CustomLable(
                size: size,
                title: "Text to speech settings",
                change: true,
              ),
              const SizedBox(height: 15),
              StreamBuilder<double>(
                stream: _speechrate.stream,
                initialData: _control.speechraterx.value,
                builder: (context, snap) {
                  return SettingSlider(
                    size: size,
                    mainvariable: snap.data!,
                    title: "Speech rate - ${snap.data!}",
                    onchange: (double value) {
                      _control.vibrateclick();
                      _speechrate.sink.add(value);
                      _control.speeechratchange(value);
                      prefsetdouble("SpeechRate", value);
                    },
                    dark: _control.darkmoderx.value,
                  );
                },
              ),
              const SizedBox(height: 20),
              StreamBuilder<double>(
                stream: _pitch.stream,
                initialData: _control.pitchrx.value,
                builder: (context, snap) {
                  return SettingSlider(
                    size: size,
                    mainvariable: snap.data!,
                    title: "Pitch - ${snap.data!}",
                    onchange: (double value) {
                      _control.vibrateclick();
                      _pitch.sink.add(value);
                      _control.pitchchange(value);
                      prefsetdouble("Pitch", value);
                    },
                    dark: _control.darkmoderx.value,
                  );
                },
              ),
              const SizedBox(height: 10),
              // SettingButton(
              //   size: size,
              //   title: "Change speaker voice",
              //   secondtext:
              //       "Tap/Click to choose your preferred English language accent",
              //   onclick: () {
              //     _control.vibrateclick();
              //   },
              //   dark: _control.darkmoderx.value,
              // ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: grycol.withOpacity(0.6),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              const SizedBox(height: 10),
              CustomLable(
                size: size,
                title: "Article Font size",
                change: true,
              ),
              const SizedBox(height: 15),
              StreamBuilder<double>(
                stream: _fontsize.stream,
                initialData: _control.articlefontrx.value,
                builder: (context, snap) {
                  return SettingSlider(
                    size: size,
                    mainvariable: snap.data!,
                    title: "Font size - ${snap.data!}",
                    onchange: (double value) {
                      _control.vibrateclick();
                      _fontsize.sink.add(value);
                      _control.articlefontchange(value);
                      prefsetdouble("ArticleFont", value);
                    },
                    fontsize: true,
                    dark: _control.darkmoderx.value,
                  );
                },
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: grycol.withOpacity(0.6),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              const SizedBox(height: 10),
              CustomLable(
                size: size,
                title: "More",
                change: true,
              ),
              const SizedBox(height: 5),
              SettingButton(
                size: size,
                title: "Send Feedback",
                secondtext: "Got any queries? We are happy to help!",
                onclick: () async {
                  _control.vibrateclick();
                  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                  if (Platform.isAndroid) {
                    AndroidDeviceInfo android = await deviceInfo.androidInfo;
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    final mailtoLink = Mailto(
                      to: ['keniljasani9@gmail.com'],
                      subject: 'Feedback for Love Quotes App',
                      body:
                          '\n-------------------------------------\nPlease keep the following information\n-------------------------------------\n\nApp Version : ${packageInfo.version}\nApp Build Number : ${packageInfo.buildNumber}\nOS Version : ${android.version.sdkInt}\nDevice Brand : ${android.brand}\nDevice Model: ${android.model}\nDevice Manufacturer : ${android.manufacturer}\n',
                    );
                    if (await canLaunch('$mailtoLink')) {
                      await launch('$mailtoLink');
                    } else {
                      debugPrint('Could not launch $mailtoLink');
                    }
                  } else if (Platform.isIOS) {
                    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                    PackageInfo packageInfo = await PackageInfo.fromPlatform();
                    final mailtoLink = Mailto(
                      to: ['keniljasani9@gmail.com'],
                      subject: 'Feedback for Love Quotes App',
                      body:
                          '\n-------------------------------------\nPlease keep the following information\n-------------------------------------\n\nApp Version : ${packageInfo.version}\nApp Build Number : ${packageInfo.buildNumber}\nOS Version : ${iosInfo.systemVersion}\nDevice Brand : ${iosInfo.systemName}\nDevice Model: ${iosInfo.name}\nDevice Manufacturer : ${iosInfo.model}\n',
                    );
                    if (await canLaunch('$mailtoLink')) {
                      await launch('$mailtoLink');
                    } else {
                      debugPrint('Could not launch $mailtoLink');
                    }
                  } else {
                    debugPrint("Nothing");
                  }
                },
                dark: _control.darkmoderx.value,
              ),
              SettingButton(
                size: size,
                title: "Update to latest version",
                onclick: () async {
                  _control.vibrateclick();
                  if (Platform.isAndroid) {
                    final _update =
                        await FirebaseHelper().updaterequired("Android");
                    if (_update) {
                      StoreRedirect.redirect(
                        androidAppId: "com.lovequote.mt",
                        iOSAppId: "",

                        ///  need to add appid
                      );
                    } else {
                      Get.snackbar(
                        "No need to Update",
                        "This is the latest version",
                        backgroundColor: Colors.green,
                        colorText: whit,
                      );
                    }
                  } else {
                    final _update =
                        await FirebaseHelper().updaterequired("iOS");
                    if (_update) {
                      StoreRedirect.redirect(
                        androidAppId: "com.lovequote.mt",
                        iOSAppId: "",

                        ///  need to add appid
                      );
                    } else {
                      Get.snackbar(
                        "No need to Update",
                        "This is the latest version",
                        backgroundColor: Colors.green,
                        colorText: whit,
                      );
                    }
                  }
                },
                dark: _control.darkmoderx.value,
              ),
              // SettingButton(
              //   size: size,
              //   title: "Follow us on instagram",
              //   onclick: () {
              //     _control.vibrateclick();
              //   },
              //   dark: _control.darkmoderx.value,
              // ),
              SettingButton(
                size: size,
                title: "Privacy Policy",
                onclick: () {
                  _control.vibrateclick();
                },
                dark: _control.darkmoderx.value,
              ),
              // SettingButton(
              //   size: size,
              //   title: "Credits",
              //   onclick: () {
              //     _control.vibrateclick();
              //   },
              //   dark: _control.darkmoderx.value,
              // ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
