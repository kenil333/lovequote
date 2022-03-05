import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailto/mailto.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import './../../domain/all.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final _version = StringStream();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then(
      (_) async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        _version.sink.add(packageInfo.version);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _version.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _control = Get.put(GlobalCache());
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
            "About",
            style: TextStyle(
              letterSpacing: 1.5,
              color: _control.darkmoderx.value ? whit : black87,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Row(
                  children: [
                    Image.asset(
                      appiconimg,
                      width: size.width * 0.22,
                      height: size.width * 0.22,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deep Love Quotes",
                            style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.w500,
                              color: _control.darkmoderx.value ? whit : black87,
                            ),
                          ),
                          StreamBuilder<String>(
                            stream: _version.stream,
                            initialData: "1.0",
                            builder: (context, versionsnap) {
                              return Text(
                                "version: ${versionsnap.data!}",
                                style: TextStyle(
                                  fontSize: size.width * 0.032,
                                  color: _control.darkmoderx.value
                                      ? whit
                                      : black25,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.\n\nIt has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.\n\nIt was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: size.width * 0.042,
                    color: _control.darkmoderx.value
                        ? whit.withOpacity(0.65)
                        : black87.withOpacity(0.65),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              DrawerButton(
                size: size,
                title: "Share the app",
                image: ds2img,
                onclick: () {
                  _control.vibrateclick();
                  if (Platform.isAndroid) {
                    Share.share(
                      "Hi! Take a look at this amazing app Love Quotes. It's a great app and It's free! You should get it too.\n\nhttps://play.google.com/store/apps/details?id=com.lovequote.mt",
                    );
                  } else if (Platform.isIOS) {
                    Share.share(
                      "Hi! Take a look at this amazing app Love Quotes. It's a great app and It's free! You should get it too.\n\nhttps://apps.apple.com/",
                    );
                  } else {}
                },
                dark: _control.darkmoderx.value,
              ),
              DrawerButton(
                size: size,
                title: "Email the developer",
                image: ds4img,
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
              DrawerButton(
                size: size,
                title: "Rate on Appstore",
                image: ds3img,
                onclick: () {
                  _control.vibrateclick();
                  StoreRedirect.redirect(
                    androidAppId: "com.lovequote.mt",
                    iOSAppId: "",

                    ///  need to add appid
                  );
                },
                dark: _control.darkmoderx.value,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
