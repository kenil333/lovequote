import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import './../../domain/all.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({Key? key}) : super(key: key);

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final _videolist = VideoListStream();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then(
      (_) async {
        _videolist.sink.add(await FirebaseHelper().getvideos());
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _videolist.dispose();
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
            "Videos",
            style: TextStyle(
              letterSpacing: 1.5,
              color: _control.darkmoderx.value ? whit : black87,
            ),
          ),
        ),
        body: StreamBuilder<List<VideoModel>>(
          stream: _videolist.stream,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitSpinningLines(
                  color: redcol,
                  size: 100.0,
                ),
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 4,
                itemBuilder: (context, i) => InkWell(
                  onTap: () async {
                    _control.vibrateclick();
                    if (await canLaunch(snap.data![i].link)) {
                      await launch(snap.data![i].link);
                    } else {
                      debugPrint('Could not launch ${snap.data![i].link}');
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    margin: EdgeInsets.only(
                      left: size.width * 0.03,
                      right: size.width * 0.01,
                      top: i == 0 ? 20 : 0,
                      bottom: 20,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              snap.data![i].image,
                              fit: BoxFit.cover,
                              width: size.width * 0.35,
                              height: 90,
                            ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: SizedBox(
                                width: size.width * 0.35,
                                child: Row(
                                  children: [
                                    Expanded(child: Container()),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.03,
                                        vertical: 3,
                                      ),
                                      color: black87,
                                      child: Text(
                                        snap.data![i].time,
                                        style: TextStyle(
                                          fontSize: size.width * 0.03,
                                          fontWeight: FontWeight.w500,
                                          color: whit,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.04),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snap.data![i].title,
                                maxLines: 4,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: size.width * 0.038,
                                  color: _control.darkmoderx.value
                                      ? whit
                                      : black87,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "${snap.data![i].days} day ago",
                                style: TextStyle(
                                  fontSize: size.width * 0.03,
                                  color: _control.darkmoderx.value
                                      ? whit.withOpacity(0.4)
                                      : grycol,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: size.width * 0.04),
                        PopupMenuButton<String>(
                          icon: Icon(
                            Icons.more_horiz_rounded,
                            color: _control.darkmoderx.value ? whit : black87,
                          ),
                          color: _control.darkmoderx.value ? black87 : whit,
                          onSelected: (String value) async {
                            _control.vibrateclick();
                            if (value == "Watch") {
                              if (await canLaunch(snap.data![i].link)) {
                                await launch(snap.data![i].link);
                              } else {
                                debugPrint(
                                    'Could not launch ${snap.data![i].link}');
                              }
                            } else if (value == "Subscribe") {
                              if (await canLaunch(snap.data![i].channellink)) {
                                await launch(snap.data![i].channellink);
                              } else {
                                debugPrint(
                                    'Could not launch ${snap.data![i].channellink}');
                              }
                            } else {
                              Share.share(snap.data![i].link);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return {"Watch", "Share", "Subscribe"}
                                .map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(
                                  choice,
                                  style: TextStyle(
                                    color: _control.darkmoderx.value
                                        ? whit
                                        : black87,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
