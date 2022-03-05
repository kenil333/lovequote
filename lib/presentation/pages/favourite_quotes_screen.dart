import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class FavouriteQuotesScreen extends StatelessWidget {
  const FavouriteQuotesScreen({Key? key}) : super(key: key);

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
            "Favourite Quotes",
            style: TextStyle(
              letterSpacing: 1.5,
              color: _control.darkmoderx.value ? whit : black87,
            ),
          ),
        ),
        body: _control.favmessagerx.isNotEmpty
            ? ListView.builder(
                itemCount: _control.favmessagerx.length,
                itemBuilder: (context, i) => QuouteWidget(
                  size: size,
                  i: i,
                  quote: _control.favmessagerx[i],
                  onclick: (String image, int index) {
                    routepush(
                      context,
                      SaveShareScreen(
                        backima: image,
                        message: _control.favmessagerx[i].quote,
                        color: gredientlist[index],
                      ),
                    );
                  },
                ),
              )
            : Center(
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
              ),
      ),
    );
  }
}
