import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class QuotesListScreen extends StatelessWidget {
  final String title;
  const QuotesListScreen({
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
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
          itemCount: _control.quotesrx.length,
          itemBuilder: (context, i) => title == _control.quotesrx[i].category
              ? QuouteWidget(
                  size: size,
                  i: i,
                  quote: _control.quotesrx[i],
                  onclick: (String image, int index) {
                    routepush(
                      context,
                      SaveShareScreen(
                        backima: image,
                        message: _control.quotesrx[i].quote,
                        color: gredientlist[index],
                      ),
                    );
                  },
                )
              : Container(),
        ),
      ),
    );
  }
}
