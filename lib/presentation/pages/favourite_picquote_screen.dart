import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class FavouritePicQuoteScreen extends StatelessWidget {
  final String title;
  const FavouritePicQuoteScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

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
            title,
            style: TextStyle(
              letterSpacing: 1.5,
              color: _control.darkmoderx.value ? whit : black87,
            ),
          ),
        ),
        body: title == "Picture Quotes"
            ? ListView.builder(
                itemCount: _control.picquotesrx.length,
                itemBuilder: (context, i) => Container(
                  width: double.infinity,
                  height: size.height * 0.55,
                  margin: EdgeInsets.only(
                    left: size.width * 0.04,
                    right: size.width * 0.04,
                    top: i == 0 ? 20 : 0,
                    bottom: 30,
                  ),
                  decoration: containerdeco(_control.darkmoderx.value),
                  child: Column(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            _control.vibrateclick();
                            routepush(
                              context,
                              PicPreviewScreen(index: i),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: _control.picquotesrx[i].image,
                            imageBuilder: (context, imageProvider) => Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.08,
                          vertical: 18,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _control.vibrateclick();
                                routepush(
                                  context,
                                  PicPreviewScreen(index: i),
                                );
                              },
                              child: Image.asset(
                                p4img,
                                width: size.width * 0.06,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  _control.vibrateclick();
                                  _control.favpiciconpress(
                                    _control.picquotesrx[i].id,
                                    _control.picquotesrx[i].image,
                                  );
                                },
                                child: Image.asset(
                                  _control.favpicrx.any(
                                    (element) =>
                                        element.id ==
                                        _control.picquotesrx[i].id,
                                  )
                                      ? starfevimg
                                      : p6img,
                                  width: size.width * 0.06,
                                  fit: BoxFit.contain,
                                  color: _control.favpicrx.any(
                                    (element) =>
                                        element.id ==
                                        _control.picquotesrx[i].id,
                                  )
                                      ? null
                                      : Colors.blue,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _control.vibrateclick();
                                routepush(
                                  context,
                                  PicPreviewScreen(index: i),
                                );
                              },
                              child: Image.asset(
                                ds2img,
                                width: size.width * 0.06,
                                fit: BoxFit.contain,
                                // color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : _control.favpicrx.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          starfevimg,
                          width: size.width * 0.2,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No Favourite found.",
                          style: TextStyle(
                            fontSize: size.width * 0.05,
                            color: _control.darkmoderx.value ? whit : black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _control.favpicrx.length,
                    itemBuilder: (context, i) => Container(
                      width: double.infinity,
                      height: size.height * 0.55,
                      margin: EdgeInsets.only(
                        left: size.width * 0.04,
                        right: size.width * 0.04,
                        top: i == 0 ? 20 : 0,
                        bottom: 30,
                      ),
                      decoration: containerdeco(_control.darkmoderx.value),
                      child: Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _control.vibrateclick();
                                final _index = _control.picquotesrx.indexWhere(
                                  (e) => e.id == _control.favpicrx[i].id,
                                );
                                routepush(
                                  context,
                                  PicPreviewScreen(index: _index),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      _control.favpicrx[i].image,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.08,
                              vertical: 18,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _control.vibrateclick();
                                    final _index =
                                        _control.picquotesrx.indexWhere(
                                      (e) => e.id == _control.favpicrx[i].id,
                                    );
                                    routepush(
                                      context,
                                      PicPreviewScreen(index: _index),
                                    );
                                  },
                                  child: Image.asset(
                                    p4img,
                                    width: size.width * 0.06,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      _control.vibrateclick();
                                      _control.favpiciconpress(
                                        _control.favpicrx[i].id,
                                        _control.favpicrx[i].image,
                                      );
                                    },
                                    child: Image.asset(
                                      _control.favpicrx.any((element) =>
                                              element.id ==
                                              _control.favpicrx[i].id)
                                          ? starfevimg
                                          : p6img,
                                      width: size.width * 0.06,
                                      fit: BoxFit.contain,
                                      color: _control.favpicrx.any((element) =>
                                              element.id ==
                                              _control.favpicrx[i].id)
                                          ? null
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _control.vibrateclick();
                                    final _index =
                                        _control.picquotesrx.indexWhere(
                                      (e) => e.id == _control.favpicrx[i].id,
                                    );
                                    routepush(
                                      context,
                                      PicPreviewScreen(index: _index),
                                    );
                                  },
                                  child: Image.asset(
                                    ds2img,
                                    width: size.width * 0.06,
                                    fit: BoxFit.contain,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
