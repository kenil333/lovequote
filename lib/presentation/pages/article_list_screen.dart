import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key}) : super(key: key);

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
            "Articles",
            style: TextStyle(
              letterSpacing: 1.5,
              color: _control.darkmoderx.value ? whit : black87,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: _control.articlerx.length,
          itemBuilder: (context, i) => GestureDetector(
            onTap: () {
              _control.vibrateclick();
              routepush(
                context,
                ArticleDetailScreen(
                  article: _control.articlerx[i],
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                top: i == 0 ? 20 : 0,
                bottom: 20,
                left: size.width * 0.04,
                right: size.width * 0.04,
              ),
              height: size.height * 0.32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _control.darkmoderx.value ? darkcontainer : whit,
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
                      style: TextStyle(
                        fontSize: size.width * 0.042,
                        color: _control.darkmoderx.value
                            ? whit.withOpacity(0.6)
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
    );
  }
}
