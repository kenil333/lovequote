import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailto/mailto.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import './../../../domain/all.dart';

class DrawerWidget extends StatelessWidget {
  final Size size;
  const DrawerWidget({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _control = Get.put(GlobalCache());
    return Obx(
      () => Drawer(
        backgroundColor: _control.darkmoderx.value ? screenbackdark : whit,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.2,
                padding: EdgeInsets.symmetric(vertical: size.height * 0.05),
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
                  ),
                ),
              ),
              const SizedBox(height: 15),
              DrawerButton(
                size: size,
                title: "Love Message",
                image: d1img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(
                    context,
                    SimpleListingScreen(
                      title: "Love Messages",
                      listofscreen: messagelist,
                    ),
                  );
                },
                dark: _control.darkmoderx.value,
              ),
              DrawerButton(
                size: size,
                title: "Love Quotes",
                image: d2img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(
                    context,
                    SimpleListingScreen(
                      title: "Love Quotes",
                      listofscreen: lovequoteslist,
                    ),
                  );
                },
                dark: _control.darkmoderx.value,
              ),
              DrawerButton(
                size: size,
                title: "Love Poems",
                image: d3img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(
                    context,
                    const QuotesListScreen(
                      title: "Love Poems",
                    ),
                  );
                },
                dark: _control.darkmoderx.value,
              ),
              DrawerButton(
                size: size,
                title: "Favourites",
                image: d4img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(context, const FavouriteQuotesScreen());
                },
                dark: _control.darkmoderx.value,
              ),
              DrawerButton(
                size: size,
                title: "Quotes of the Day",
                image: d5img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(
                    context,
                    const PreviewScreen(
                      id: "0",
                      title:
                          "First best is falling in love, Second best is being in love. Least best is falling out of love. But any of it is better than never having benn in love",
                      category: "Today Quote",
                    ),
                  );
                },
                dark: _control.darkmoderx.value,
              ),
              DrawerButton(
                size: size,
                title: "Favourite pic Quotes",
                image: d6img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(
                    context,
                    const FavouritePicQuoteScreen(
                      title: "Favourite Pic Quotes",
                    ),
                  );
                },
                dark: _control.darkmoderx.value,
              ),
              DrawerButton(
                size: size,
                title: "Videos",
                image: d7img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(context, const VideoListScreen());
                },
                dark: _control.darkmoderx.value,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                color: grycol.withOpacity(0.6),
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              CustomLable(
                size: size,
                title: "Communicate",
                dark: _control.darkmoderx.value,
              ),
              DrawerButton(
                size: size,
                title: "Settings",
                image: ds1img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(context, const SettingScreen());
                },
                dark: _control.darkmoderx.value,
                // color: true,
              ),
              DrawerButton(
                size: size,
                title: "Share",
                image: ds2img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.of(context).pop();
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
                // color: true,
              ),
              DrawerButton(
                size: size,
                title: "Rate",
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
                // color: true,
              ),
              DrawerButton(
                size: size,
                title: "Feedback",
                image: ds4img,
                onclick: () async {
                  _control.vibrateclick();
                  Navigator.of(context).pop();
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
                // color: true,
              ),
              // DrawerButton(
              //   size: size,
              //   title: "More apps",
              //   image: ds5img,
              //   onclick: () {
              //     _control.vibrateclick();
              //   },
              //   dark: _control.darkmoderx.value,
              //   // color: true,
              // ),
              DrawerButton(
                size: size,
                title: "About",
                image: ds6img,
                onclick: () {
                  _control.vibrateclick();
                  Navigator.pop(context);
                  routepush(context, const AboutScreen());
                },
                dark: _control.darkmoderx.value,
                // color: true,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
