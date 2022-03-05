import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import './../../domain/all.dart';

class PreviewScreen extends StatefulWidget {
  final String id;
  final String title;
  final String category;
  const PreviewScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.category,
  }) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final ScreenshotController _screencontroller = ScreenshotController();
  final _control = Get.put(GlobalCache());
  final _preview = Get.put(PreviewController());
  final _backcolor = ColorStream();
  final _backimage = IntStream();

  @override
  void dispose() {
    _preview.imagechange(0);
    _backcolor.dispose();
    _backimage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (widget.title.length > 700) {
      _preview.fontsizerx.value = 13;
    } else if (widget.title.length > 660 && widget.title.length < 700) {
      _preview.fontsizerx.value = 14;
    } else if (widget.title.length > 500 && widget.title.length < 660) {
      _preview.fontsizerx.value = 15;
    } else if (widget.title.length > 400 && widget.title.length < 500) {
      _preview.fontsizerx.value = 17;
    } else if (widget.title.length > 300 && widget.title.length < 400) {
      _preview.fontsizerx.value = 19;
    } else if (widget.title.length > 200 && widget.title.length < 300) {
      _preview.fontsizerx.value = 22;
    } else if (widget.title.length > 100 && widget.title.length < 200) {
      _preview.fontsizerx.value = 24;
    } else {
      _preview.fontsizerx.value = 25;
    }
    return Scaffold(
      body: StreamBuilder<int>(
        stream: _backimage.stream,
        initialData: Random().nextInt(_control.imagesrx.length),
        builder: (context, imagesnap) {
          return Stack(
            fit: StackFit.expand,
            children: [
              StreamBuilder<Color?>(
                stream: _backcolor.stream,
                initialData: null,
                builder: (context, snapshot) {
                  return Screenshot(
                    controller: _screencontroller,
                    child: StreamBuilder<int>(
                      stream: _backimage.stream,
                      initialData: Random().nextInt(_control.imagesrx.length),
                      builder: (context, imagesnap) {
                        return CachedNetworkImage(
                          imageUrl: _control.imagesrx[imagesnap.data!],
                          imageBuilder: (context, imageProvider) => Obx(
                            () => Container(
                              width: size.width,
                              height: size.height,
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                              ),
                              decoration: BoxDecoration(
                                color: snapshot.data,
                                gradient: snapshot.data == null
                                    ? _control.plainbackrx.value
                                        ? LinearGradient(
                                            colors: gredientlist[
                                                _preview.imagerx.value],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : null
                                    : null,
                                image: snapshot.data == null
                                    ? _control.plainbackrx.value
                                        ? null
                                        : DecorationImage(
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(
                                                _preview.opacityrx.value,
                                              ),
                                              BlendMode.darken,
                                            ),
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          )
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _preview.capitalrx.value
                                        ? widget.title.toUpperCase()
                                        : widget.title,
                                    textAlign: _preview.alignrx.value == "left"
                                        ? TextAlign.left
                                        : _preview.alignrx.value == "right"
                                            ? TextAlign.right
                                            : TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 30,
                                    style: TextStyle(
                                      fontSize: double.parse(
                                          _preview.fontsizerx.value.toString()),
                                      color: colorlist[_preview.colorx.value],
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                      height: 1.4,
                                      fontFamily: _preview.fontstylerx.value,
                                      shadows: const [
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
                                      decoration: _preview.underlinerx.value
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
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
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  );
                },
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 20,
                child: GestureDetector(
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
              ),
              Positioned(
                bottom: 20,
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
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: black25,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _control.vibrateclick();
                                    _backcolor.sink.add(null);
                                    if (_control.plainbackrx.value) {
                                      if (_preview.imagerx.value ==
                                          (gredientlist.length - 1)) {
                                        _preview.imagechange(0);
                                      } else {
                                        _preview.imagechange(
                                            _preview.imagerx.value + 1);
                                      }
                                    } else {
                                      if (imagesnap.data! ==
                                          (_control.imagesrx.length - 1)) {
                                        _backimage.sink.add(0);
                                      } else {
                                        _backimage.sink
                                            .add(imagesnap.data! + 1);
                                      }
                                    }
                                    _preview.editchange(false);
                                  },
                                  child: Image.asset(
                                    p1img,
                                    width: size.width * 0.06,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _control.vibrateclick();
                                    _preview.editchange(!_preview.editrx.value);
                                  },
                                  child: Image.asset(
                                    p2img,
                                    width: size.width * 0.06,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  padding: EdgeInsets.zero,
                                  icon: Image.asset(
                                    p3img,
                                    width: size.width * 0.06,
                                    fit: BoxFit.contain,
                                  ),
                                  color: _control.darkmoderx.value
                                      ? black87
                                      : whit,
                                  onSelected: (String value) async {
                                    _control.vibrateclick();
                                    _preview.editchange(false);
                                    if (value == "Copy Text") {
                                      Clipboard.setData(
                                        ClipboardData(text: widget.title),
                                      );
                                    } else {
                                      Share.share(widget.title);
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
                                  onTap: () async {
                                    _control.vibrateclick();
                                    _preview.editchange(false);
                                    _preview.lodingchange(true);
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
                                        _preview.lodingchange(false);
                                        Get.snackbar(
                                          "Success",
                                          "Your Image Saved in Phots Gallery.",
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
                                  onTap: () {
                                    _control.vibrateclick();
                                    _preview.editchange(false);
                                    routepush(
                                      context,
                                      ThemeScreen(
                                        colorpicker: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text("Choose Color"),
                                              content: SingleChildScrollView(
                                                child: MaterialPicker(
                                                  pickerColor: Colors.orange,
                                                  onColorChanged:
                                                      (Color? color) {
                                                    _backcolor.sink.add(color);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        imageselect: (int index) {
                                          _backimage.sink.add(index);
                                          _control.plainbackchange(false);
                                        },
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    p5img,
                                    width: size.width * 0.06,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _control.vibrateclick();
                                    _preview.editchange(false);
                                    _control.faviconpress(widget.id,
                                        widget.title, widget.category);
                                  },
                                  child: Image.asset(
                                    _control.favmessagerx.any((element) =>
                                            element.id == widget.id)
                                        ? starfevimg
                                        : p6img,
                                    width: size.width * 0.06,
                                    fit: BoxFit.contain,
                                    color: _control.favmessagerx.any(
                                            (element) =>
                                                element.id == widget.id)
                                        ? null
                                        : Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width * 0.03),
                    ],
                  ),
                ),
              ),
              Obx(
                () {
                  if (_preview.editrx.value) {
                    return Positioned(
                      bottom: 80,
                      child: Container(
                        width: size.width,
                        color: screenbackdark,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: size.width * 0.02,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _preview.selectedchange("Size");
                                  },
                                  child: Text(
                                    "Size",
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: _preview.selectedrx.value == "Size"
                                          ? whit
                                          : whit.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _preview.selectedchange("Color");
                                  },
                                  child: Text(
                                    "Color",
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color:
                                          _preview.selectedrx.value == "Color"
                                              ? whit
                                              : whit.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _preview.selectedchange("Font");
                                  },
                                  child: Text(
                                    "Font",
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: _preview.selectedrx.value == "Font"
                                          ? whit
                                          : whit.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _preview.selectedchange("Alignment");
                                  },
                                  child: Text(
                                    "Alignment",
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: _preview.selectedrx.value ==
                                              "Alignment"
                                          ? whit
                                          : whit.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _preview.selectedchange("Background");
                                  },
                                  child: Text(
                                    "Background",
                                    style: TextStyle(
                                      fontSize: size.width * 0.04,
                                      color: _preview.selectedrx.value ==
                                              "Background"
                                          ? whit
                                          : whit.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Obx(
                              () {
                                if (_preview.selectedrx.value == "Size") {
                                  return Row(
                                    children: [
                                      const SizedBox(width: 5),
                                      Text(
                                        "Text size",
                                        style: TextStyle(
                                          fontSize: size.width * 0.038,
                                          color: whit.withOpacity(0.7),
                                        ),
                                      ),
                                      Expanded(child: Container()),
                                      InkWell(
                                        onTap: () {
                                          if (_preview.fontsizerx.value > 10) {
                                            _preview.fontsizechange(
                                                _preview.fontsizerx.value - 1);
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05,
                                            vertical: 8,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: darkcontainer,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(100),
                                              bottomLeft: Radius.circular(100),
                                            ),
                                          ),
                                          child: Text(
                                            "A-",
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              color: whit.withOpacity(0.4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        _preview.fontsizerx.value.toString(),
                                        style: TextStyle(
                                          fontSize: size.width * 0.042,
                                          color: whit.withOpacity(0.5),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      InkWell(
                                        onTap: () {
                                          if (widget.title.length > 700) {
                                            if (_preview.fontsizerx.value <
                                                13) {
                                              _preview.fontsizechange(
                                                  _preview.fontsizerx.value +
                                                      1);
                                            }
                                          } else if (widget.title.length >
                                                  560 &&
                                              widget.title.length < 700) {
                                            if (widget.title.length > 660) {
                                              if (_preview.fontsizerx.value <
                                                  14) {
                                                _preview.fontsizechange(
                                                    _preview.fontsizerx.value +
                                                        1);
                                              } else {
                                                if (_preview.fontsizerx.value <
                                                    15) {
                                                  _preview.fontsizechange(
                                                      _preview.fontsizerx
                                                              .value +
                                                          1);
                                                }
                                              }
                                            }
                                          } else if (widget.title.length >
                                                  500 &&
                                              widget.title.length < 560) {
                                            if (_preview.fontsizerx.value <
                                                16) {
                                              _preview.fontsizechange(
                                                  _preview.fontsizerx.value +
                                                      1);
                                            }
                                          } else if (widget.title.length >
                                                  400 &&
                                              widget.title.length < 500) {
                                            if (_preview.fontsizerx.value <
                                                18) {
                                              _preview.fontsizechange(
                                                  _preview.fontsizerx.value +
                                                      1);
                                            }
                                          } else if (widget.title.length >
                                                  300 &&
                                              widget.title.length < 400) {
                                            if (_preview.fontsizerx.value <
                                                20) {
                                              _preview.fontsizechange(
                                                  _preview.fontsizerx.value +
                                                      1);
                                            }
                                          } else if (widget.title.length >
                                                  200 &&
                                              widget.title.length < 300) {
                                            if (_preview.fontsizerx.value <
                                                25) {
                                              _preview.fontsizechange(
                                                  _preview.fontsizerx.value +
                                                      1);
                                            }
                                          } else if (widget.title.length >
                                                  100 &&
                                              widget.title.length < 200) {
                                            if (_preview.fontsizerx.value <
                                                28) {
                                              _preview.fontsizechange(
                                                  _preview.fontsizerx.value +
                                                      1);
                                            }
                                          } else {
                                            if (_preview.fontsizerx.value <
                                                35) {
                                              _preview.fontsizechange(
                                                  _preview.fontsizerx.value +
                                                      1);
                                            }
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.05,
                                            vertical: 8,
                                          ),
                                          decoration: const BoxDecoration(
                                            color: darkcontainer,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(100),
                                              bottomRight: Radius.circular(100),
                                            ),
                                          ),
                                          child: Text(
                                            "A+",
                                            style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              color: whit.withOpacity(0.4),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                    ],
                                  );
                                } else if (_preview.selectedrx.value ==
                                    "Color") {
                                  return Row(
                                    children: [
                                      const SizedBox(width: 5),
                                      Text(
                                        "Text Color",
                                        style: TextStyle(
                                          fontSize: size.width * 0.038,
                                          color: whit.withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(width: 35),
                                      Expanded(
                                        child: SizedBox(
                                          height: 35,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: colorlist.length,
                                            itemBuilder: (context, i) =>
                                                InkWell(
                                              onTap: () {
                                                _preview.colorchange(i);
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  right: 20,
                                                  top: 3,
                                                  bottom: 3,
                                                ),
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color: colorlist[i],
                                                  border: Border.all(
                                                    width: 1,
                                                    color: whit,
                                                  ),
                                                ),
                                                child: Obx(
                                                  () =>
                                                      i != _preview.colorx.value
                                                          ? Container()
                                                          : Icon(
                                                              Icons.check,
                                                              color: colorlist[_preview
                                                                          .colorx
                                                                          .value] ==
                                                                      whit
                                                                  ? black87
                                                                  : whit,
                                                              size: size.width *
                                                                  0.05,
                                                            ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (_preview.selectedrx.value ==
                                    "Font") {
                                  return Row(
                                    children: [
                                      const SizedBox(width: 5),
                                      Text(
                                        "Font Style",
                                        style: TextStyle(
                                          fontSize: size.width * 0.038,
                                          color: whit.withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(width: 35),
                                      Expanded(
                                        child: SizedBox(
                                          height: 35,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: fontstylelist.length,
                                            itemBuilder: (context, i) => Obx(
                                              () => InkWell(
                                                onTap: () {
                                                  _preview.fontstylechange(
                                                      fontstylelist[i]);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                    right: 20,
                                                    top: 3,
                                                    bottom: 3,
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: fontstylelist[i] ==
                                                            _preview.fontstylerx
                                                                .value
                                                        ? Colors.red[300]
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Sample",
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.width * 0.04,
                                                      color:
                                                          whit.withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          fontstylelist[i],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (_preview.selectedrx.value ==
                                    "Alignment") {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Alignment",
                                          style: TextStyle(
                                            fontSize: size.width * 0.038,
                                            color: whit.withOpacity(0.7),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _preview.alignchange("left");
                                          },
                                          child: Icon(
                                            Icons.format_align_left,
                                            color: whit.withOpacity(0.5),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _preview.alignchange("center");
                                          },
                                          child: Icon(
                                            Icons.format_align_center,
                                            color: whit.withOpacity(0.5),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _preview.alignchange("right");
                                          },
                                          child: Icon(
                                            Icons.format_align_right,
                                            color: whit.withOpacity(0.5),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _preview.underlinechange(
                                                !_preview.underlinerx.value);
                                          },
                                          child: Icon(
                                            Icons.format_underline,
                                            color: whit.withOpacity(0.5),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _preview.capitalchange(
                                                !_preview.capitalrx.value);
                                          },
                                          child: Icon(
                                            Icons.format_size_rounded,
                                            color: whit.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Opacity",
                                          style: TextStyle(
                                            fontSize: size.width * 0.038,
                                            color: whit.withOpacity(0.7),
                                          ),
                                        ),
                                        Container(),
                                        InkWell(
                                          onTap: () {
                                            if (_preview.opacityrx.value <
                                                0.9) {
                                              _preview.opacitychange(
                                                  _preview.opacityrx.value +
                                                      0.1);
                                            }
                                          },
                                          child: Icon(
                                            Icons.brightness_low_sharp,
                                            color: whit.withOpacity(0.5),
                                          ),
                                        ),
                                        Text(
                                          "${(_preview.opacityrx.value * 100).toStringAsFixed(0)}%",
                                          style: TextStyle(
                                            fontSize: size.width * 0.042,
                                            color: whit.withOpacity(0.5),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (_preview.opacityrx.value >
                                                0.1) {
                                              _preview.opacitychange(
                                                  _preview.opacityrx.value -
                                                      0.1);
                                            }
                                          },
                                          child: Icon(
                                            Icons.brightness_high_sharp,
                                            color: whit.withOpacity(0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Obx(
                () => _preview.lodingrx.value
                    ? Container(
                        width: size.width,
                        height: size.height,
                        color: Colors.black54,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(),
              ),
            ],
          );
        },
      ),
    );
  }
}
