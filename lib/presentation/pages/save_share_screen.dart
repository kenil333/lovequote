import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

import './../../domain/all.dart';

class SaveShareScreen extends StatefulWidget {
  final String backima;
  final String message;
  final List<Color> color;
  const SaveShareScreen({
    Key? key,
    required this.backima,
    required this.message,
    required this.color,
  }) : super(key: key);

  @override
  State<SaveShareScreen> createState() => _SaveShareScreenState();
}

class _SaveShareScreenState extends State<SaveShareScreen> {
  final _control = Get.put(GlobalCache());
  final ScreenshotController _screencontroller = ScreenshotController();
  final _loding = BoolStream();

  @override
  void dispose() {
    _loding.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Screenshot(
            controller: _screencontroller,
            child: CachedNetworkImage(
              imageUrl: widget.backima,
              imageBuilder: (context, imageProvider) => Obx(
                () => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                  ),
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    gradient: _control.plainbackrx.value
                        ? LinearGradient(
                            colors: widget.color,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    image: _control.plainbackrx.value
                        ? null
                        : backimage(imageProvider),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          color: whit,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          height: 1.4,
                          shadows: [
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              placeholder: (context, url) => Container(
                color: screenbackdark,
                child: const Center(
                  child: SpinKitSpinningLines(
                    color: redcol,
                    size: 100.0,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 15,
            child: SizedBox(
              width: size.width,
              child: Row(
                children: [
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: black25,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          GestureDetector(
                            onTap: () async {
                              _control.vibrateclick();
                              _loding.sink.add(true);
                              await _screencontroller
                                  .capture(
                                delay: const Duration(milliseconds: 10),
                              )
                                  .then((Uint8List? image) async {
                                if (image != null) {
                                  final directory =
                                      await getApplicationDocumentsDirectory();
                                  String fileName = DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString();
                                  final imagePath = await File(
                                          '${directory.path}/$fileName.png')
                                      .create();
                                  await imagePath.writeAsBytes(image);
                                  _loding.sink.add(false);

                                  await Share.shareFiles([imagePath.path]);
                                }
                              });
                            },
                            child: Image.asset(
                              ds2img,
                              width: size.width * 0.07,
                              fit: BoxFit.contain,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _control.vibrateclick();
                              _loding.sink.add(true);
                              await _screencontroller
                                  .capture(
                                delay: const Duration(milliseconds: 10),
                              )
                                  .then(
                                (Uint8List? value) async {
                                  await ImageGallerySaver.saveImage(
                                    value!,
                                    quality: 100,
                                  );
                                  _loding.sink.add(false);
                                  Get.snackbar(
                                    "Success",
                                    "Your Image Saved in Photos Gallery.",
                                    colorText: whit,
                                    backgroundColor: Colors.green[200],
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              p4img,
                              width: size.width * 0.07,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                ],
              ),
            ),
          ),
          StreamBuilder<bool>(
            stream: _loding.stream,
            initialData: false,
            builder: (context, snap) {
              if (snap.data!) {
                return Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
