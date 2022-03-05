import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import './../../../domain/all.dart';

class QuouteWidget extends StatefulWidget {
  final Size size;
  final int i;
  final QuoteModel quote;
  final Function onclick;
  const QuouteWidget({
    Key? key,
    required this.size,
    required this.i,
    required this.quote,
    required this.onclick,
  }) : super(key: key);

  @override
  State<QuouteWidget> createState() => _QuouteWidgetState();
}

class _QuouteWidgetState extends State<QuouteWidget> {
  final _index = IntStream();
  final _imageback = StringStream();

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _control = Get.put(GlobalCache());
    return StreamBuilder<int>(
      stream: _index.stream,
      initialData: 0,
      builder: (context, snap) {
        return StreamBuilder<String>(
          stream: _imageback.stream,
          initialData:
              _control.imagesrx[Random().nextInt(_control.imagesrx.length)],
          builder: (context, backsnap) {
            return Container(
              width: double.infinity,
              height: widget.size.height * 0.55,
              margin: EdgeInsets.only(
                left: widget.size.width * 0.04,
                right: widget.size.width * 0.04,
                top: widget.i == 0 ? 20 : 0,
                bottom: 30,
              ),
              decoration: containerdeco(_control.darkmoderx.value),
              child: Column(
                children: [
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: backsnap.data!,
                      imageBuilder: (context, imageProvider) => InkWell(
                        onTap: () {
                          _control.vibrateclick();
                          routepush(
                            context,
                            PreviewScreen(
                              id: widget.quote.id,
                              title: widget.quote.quote,
                              category: widget.quote.category,
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.size.width * 0.04,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            gradient: _control.plainbackrx.value
                                ? LinearGradient(
                                    colors: gredientlist[snap.data!],
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
                                widget.quote.quote,
                                textAlign: TextAlign.center,
                                maxLines: 10,
                                overflow: TextOverflow.clip,
                                style: whitetext(widget.size.width * 0.05),
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.size.width * 0.06,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _control.vibrateclick();
                            if (_control.plainbackrx.value) {
                              if (snap.data! == (gredientlist.length - 1)) {
                                _index.sink.add(0);
                              } else {
                                _index.sink.add(snap.data! + 1);
                              }
                            } else {
                              _imageback.sink.add(_control.imagesrx[
                                  Random().nextInt(_control.imagesrx.length)]);
                            }
                          },
                          child: Image.asset(
                            p1img,
                            width: widget.size.width * 0.06,
                            fit: BoxFit.contain,
                          ),
                        ),
                        PopupMenuButton<String>(
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                            p3img,
                            width: widget.size.width * 0.06,
                            fit: BoxFit.contain,
                          ),
                          color: _control.darkmoderx.value ? black87 : whit,
                          onSelected: (String value) async {
                            _control.vibrateclick();
                            if (value == "Copy Text") {
                              Clipboard.setData(
                                ClipboardData(text: widget.quote.quote),
                              );
                            } else {
                              Share.share(widget.quote.quote);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return {"Copy Text", "Share as Text"}
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
                        GestureDetector(
                          onTap: () {
                            _control.vibrateclick();
                            widget.onclick(
                              backsnap.data!,
                              snap.data!,
                            );
                          },
                          child: Image.asset(
                            ds2img,
                            width: widget.size.width * 0.06,
                            fit: BoxFit.contain,
                            // color: Colors.red,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _control.vibrateclick();
                            widget.onclick(
                              backsnap.data!,
                              snap.data!,
                            );
                          },
                          child: Image.asset(
                            p4img,
                            width: widget.size.width * 0.06,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Obx(
                          () => GestureDetector(
                            onTap: () {
                              _control.vibrateclick();
                              _control.faviconpress(
                                widget.quote.id,
                                widget.quote.quote,
                                widget.quote.category,
                              );
                            },
                            child: Image.asset(
                              _control.favmessagerx.any((element) =>
                                      element.id == widget.quote.id)
                                  ? starfevimg
                                  : p6img,
                              width: widget.size.width * 0.06,
                              fit: BoxFit.contain,
                              color: _control.favmessagerx.any((element) =>
                                      element.id == widget.quote.id)
                                  ? null
                                  : Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
