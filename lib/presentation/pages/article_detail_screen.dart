import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;
  const ArticleDetailScreen({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final _control = Get.put(GlobalCache());
  final _play = BoolStream();
  FlutterTts flutterTts = FlutterTts();

  @override
  void dispose() {
    _play.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: _control.darkmoderx.value ? screenbackdark : whit,
        appBar: AppBar(
          backgroundColor: _control.darkmoderx.value ? appbardark : whit,
          iconTheme: IconThemeData(
            color: _control.darkmoderx.value ? whit : black87,
          ),
          actions: [
            // InkWell(
            //   onTap: () {
            //     _control.vibrateclick();
            //   },
            //   child: Image.asset(
            //     ds2img,
            //     fit: BoxFit.contain,
            //     width: size.width * 0.06,
            //     // color: black87.withOpacity(0.65),
            //   ),
            // ),
            SizedBox(width: size.width * 0.08),
            StreamBuilder<bool>(
              stream: _play.stream,
              initialData: false,
              builder: (context, snap) {
                return InkWell(
                  onTap: () async {
                    _control.vibrateclick();
                    if (snap.data!) {
                      _play.sink.add(false);
                      await flutterTts.stop();
                    } else {
                      _play.sink.add(true);
                      await flutterTts
                          .setSpeechRate(_control.speechraterx.value / 2);
                      await flutterTts.setPitch(_control.pitchrx.value);
                      await flutterTts.speak(
                        widget.article.content,
                      );
                    }
                  },
                  child: Image.asset(
                    snap.data! ? unmuteimg : muteimg,
                    fit: BoxFit.contain,
                    width: size.width * 0.06,
                  ),
                );
              },
            ),

            SizedBox(width: size.width * 0.04),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Text(
                  widget.article.title,
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: _control.darkmoderx.value ? whit : black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: size.height * 0.3,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.article.image,
                    placeholder: (context, url) => const Center(
                      child: SpinKitSpinningLines(
                        color: redcol,
                        size: 100.0,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Text(
                  widget.article.content,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: _control.articlefontrx.value,
                    color: _control.darkmoderx.value
                        ? whit.withOpacity(0.65)
                        : black87.withOpacity(0.65),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomLable(
                size: size,
                title: "Read more",
                dark: _control.darkmoderx.value,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 220,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: _control.articlerx.length,
                  itemBuilder: (context, i) => (_control.articlerx[i].id ==
                          widget.article.id)
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            _control.vibrateclick();
                            _play.sink.add(false);
                            flutterTts.stop();
                            routepush(
                              context,
                              ArticleDetailScreen(
                                  article: _control.articlerx[i]),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: i == 0 ? size.width * 0.04 : 0,
                              right: 20,
                            ),
                            width: size.width * 0.7,
                            decoration: BoxDecoration(
                              color: _control.darkmoderx.value
                                  ? darkcontainer
                                  : whit,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: _control.darkmoderx.value
                                      ? black87
                                      : grycol.withOpacity(0.5),
                                  blurRadius: 4.0,
                                  spreadRadius: 0.0,
                                  offset: const Offset(
                                    0.0,
                                    2.0,
                                  ),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: _control.articlerx[i].image,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SpinKitSpinningLines(
                                            color: redcol,
                                            size: 100.0,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03,
                                    vertical: 10,
                                  ),
                                  // height: 50,
                                  child: Text(
                                    _control.articlerx[i].title,
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: size.width * 0.038,
                                      color: _control.darkmoderx.value
                                          ? whit.withOpacity(0.7)
                                          : black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
