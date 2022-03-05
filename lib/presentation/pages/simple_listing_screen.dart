import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class SimpleListingScreen extends StatelessWidget {
  final String title;
  final List<ImageTitle> listofscreen;
  const SimpleListingScreen({
    Key? key,
    required this.title,
    required this.listofscreen,
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
        body: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: listofscreen.length,
          itemBuilder: (context, i) => GestureDetector(
            onTap: () {
              _control.vibrateclick();
              routepush(
                context,
                QuotesListScreen(
                  title: listofscreen[i].title,
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: size.height * 0.25,
              margin: EdgeInsets.only(
                left: size.width * 0.03,
                right: size.width * 0.03,
                top: i == 0 ? 20 : 0,
                bottom: 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: backimage(AssetImage(listofscreen[i].image)),
              ),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Text(
                        listofscreen[i].title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: whitetext(size.width * 0.045),
                      ),
                      Expanded(child: Container()),
                    ],
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
