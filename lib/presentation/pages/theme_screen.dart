import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class ThemeScreen extends StatelessWidget {
  final Function colorpicker;
  final Function imageselect;
  const ThemeScreen({
    Key? key,
    required this.colorpicker,
    required this.imageselect,
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
            "Choose Theme",
            style: TextStyle(
              letterSpacing: 1.5,
              color: _control.darkmoderx.value ? whit : black87,
            ),
          ),
        ),
        body: GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02,
            vertical: 20,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: size.width * 0.03,
            mainAxisSpacing: size.width * 0.03,
            childAspectRatio: 2 / 3.1,
          ),
          itemCount: _control.imagesrx.length + 1,
          itemBuilder: (context, i) => InkWell(
            onTap: () {
              if (i == 0) {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 500)).then(
                  (_) {
                    colorpicker();
                  },
                );
              } else {
                Navigator.of(context).pop();
                Future.delayed(const Duration(milliseconds: 500)).then(
                  (_) {
                    imageselect(i - 1);
                  },
                );
              }
            },
            child: i == 0
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      colorwheelimg,
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: _control.imagesrx[i - 1],
                      placeholder: (context, url) => Container(
                        color: screenbackdark,
                        child: const Center(
                          child: SpinKitSpinningLines(
                            color: redcol,
                            size: 80.0,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
