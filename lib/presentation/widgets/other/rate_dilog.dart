import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';

import './../../../domain/all.dart';

class RateDilog extends StatefulWidget {
  final Size size;
  const RateDilog({Key? key, required this.size}) : super(key: key);

  @override
  _RateDilogState createState() => _RateDilogState();
}

class _RateDilogState extends State<RateDilog> {
  final _control = Get.put(GlobalCache());
  final _rate = IntStream();

  @override
  void dispose() {
    _rate.dispose();
    super.dispose();
  }

  String _getimage(int i) {
    if (i == 1) {
      return r1img;
    } else if (i == 2) {
      return r2img;
    } else if (i == 3) {
      return r3img;
    } else if (i == 4) {
      return r4img;
    } else {
      return r5img;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Dialog(
        backgroundColor: _control.darkmoderx.value ? screenbackdark : whit,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: widget.size.width * 0.03),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              StreamBuilder<int>(
                stream: _rate.stream,
                initialData: 5,
                builder: (context, snap) {
                  return Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      _getimage(snap.data!),
                      width: widget.size.width * 0.15,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                "Like our App ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.size.width * 0.045,
                  color: _control.darkmoderx.value ? whit : black25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Would you mind taking a moment to rate it and provide us your valuable reviews and suggestions.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.size.width * 0.035,
                  color: _control.darkmoderx.value ? whit : black25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Thanks for your sypport!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.size.width * 0.035,
                  color: _control.darkmoderx.value ? whit : black25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              StreamBuilder<int>(
                stream: _rate.stream,
                initialData: 5,
                builder: (context, snap) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        GestureDetector(
                          onTap: () {
                            _rate.sink.add(i);
                          },
                          child: Image.asset(
                            starfevimg,
                            width: widget.size.width * 0.1,
                            fit: BoxFit.contain,
                            color: i > snap.data! ? grycol : null,
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      StoreRedirect.redirect(
                        androidAppId: "com.lovequote.mt",
                        iOSAppId: "",

                        ///  need to add appid
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.size.width * 0.09,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "RATE US",
                        style: TextStyle(
                          fontSize: widget.size.width * 0.045,
                          color: whit,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "NOT NOW",
                      style: TextStyle(
                        fontSize: widget.size.width * 0.04,
                        color: _control.darkmoderx.value ? whit : black25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      );
    });
  }
}
