import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import './../../domain/all.dart';

class PicPreviewScreen extends StatefulWidget {
  final int index;
  const PicPreviewScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<PicPreviewScreen> createState() => _PicPreviewScreenState();
}

class _PicPreviewScreenState extends State<PicPreviewScreen> {
  final _control = Get.put(GlobalCache());
  final ScreenshotController _screencontroller = ScreenshotController();
  final _loding = BoolStream();
  final _index = IntStream();

  @override
  void dispose() {
    _loding.dispose();
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: black25,
      appBar: appbarpref(false, black25),
      body: Stack(
        fit: StackFit.expand,
        children: [
          StreamBuilder<int>(
            stream: _index.stream,
            initialData: widget.index,
            builder: (context, snap) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: size.width * 0.04),
                            GestureDetector(
                              onTap: () {
                                _control.vibrateclick();
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: whit,
                                size: size.width * 0.06,
                              ),
                            ),
                            Expanded(child: Container()),
                            // GestureDetector(
                            //   onTap: () {
                            //     _control.vibrateclick();
                            //   },
                            //   child: Icon(
                            //     Icons.refresh,
                            //     color: whit,
                            //     size: size.width * 0.06,
                            //   ),
                            // ),
                            // SizedBox(width: size.width * 0.03),
                            // GestureDetector(
                            //   onTap: () {
                            //     _control.vibrateclick();
                            //   },
                            //   child: Icon(
                            //     Icons.more_vert_outlined,
                            //     color: whit,
                            //     size: size.width * 0.06,
                            //   ),
                            // ),
                            // SizedBox(width: size.width * 0.02),
                          ],
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ),
                  Screenshot(
                    controller: _screencontroller,
                    child: CachedNetworkImage(
                      imageUrl: _control.picquotesrx[snap.data!].image,
                      placeholder: (context, url) => const Center(
                        child: SpinKitSpinningLines(
                          color: redcol,
                          size: 100.0,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.contain,
                      width: size.width,
                    ),
                    // Image.network(
                    //   _control.picquotesrx[snap.data!].image,
                    //   width: size.width,
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _control.vibrateclick();
                                  if (0 != snap.data!) {
                                    _index.sink.add(snap.data! - 1);
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.blue,
                                  size: size.width * 0.06,
                                ),
                              ),
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    _control.vibrateclick();
                                    _control.favpiciconpress(
                                      _control.picquotesrx[snap.data!].id,
                                      _control.picquotesrx[snap.data!].image,
                                    );
                                  },
                                  child: Image.asset(
                                    _control.favpicrx.any(
                                      (element) =>
                                          element.id ==
                                          _control.picquotesrx[snap.data!].id,
                                    )
                                        ? starfevimg
                                        : p6img,
                                    width: size.width * 0.06,
                                    fit: BoxFit.contain,
                                    color: _control.favpicrx.any((element) =>
                                            element.id ==
                                            _control.picquotesrx[snap.data!].id)
                                        ? null
                                        : Colors.blue,
                                  ),
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
                                  width: size.width * 0.06,
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
                                  width: size.width * 0.06,
                                  fit: BoxFit.contain,
                                  // color: Colors.red,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _control.vibrateclick();
                                  if ((_control.picquotesrx.length - 1) >
                                      snap.data!) {
                                    _index.sink.add(snap.data! + 1);
                                  }
                                },
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.blue,
                                  size: size.width * 0.06,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
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
