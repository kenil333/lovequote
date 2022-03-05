import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import './../../../domain/all.dart';

class SliderWidget extends StatefulWidget {
  final Size size;
  final Function vibrate;
  final List<int> sliderlist;
  final List<int> sliderimagelist;
  const SliderWidget({
    Key? key,
    required this.size,
    required this.vibrate,
    required this.sliderlist,
    required this.sliderimagelist,
  }) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final _control = Get.put(GlobalCache());
  final _intstream = IntStream();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _intstream.stream,
      initialData: 0,
      builder: (context, snapshot) {
        return Column(
          children: [
            const SizedBox(height: 15),
            Stack(
              children: [
                CarouselSlider(
                  items: widget.sliderlist.map((i) {
                    int index = widget.sliderlist.indexOf(i);
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            widget.vibrate();
                            routepush(
                              context,
                              PreviewScreen(
                                id: _control.quotesrx[i].id,
                                title: _control.quotesrx[i].quote,
                                category: _control.quotesrx[i].category,
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: _control
                                .imagesrx[widget.sliderimagelist[index]],
                            imageBuilder: (context, imageProvider) => Obx(
                              () => Container(
                                width: widget.size.width,
                                margin: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.04,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.size.width * 0.08,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: _control.plainbackrx.value
                                      ? LinearGradient(
                                          colors: gredientlist[snapshot.data!],
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
                                  children: [
                                    Text(
                                      _control.quotesrx[i].quote,
                                      textAlign: TextAlign.center,
                                      maxLines: 5,
                                      overflow: TextOverflow.clip,
                                      style:
                                          whitetext(widget.size.width * 0.042),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: widget.size.width * 0.04,
                              ),
                              decoration: BoxDecoration(
                                  color: screenbackdark,
                                  borderRadius: BorderRadius.circular(8)),
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
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: widget.size.height * 0.25,
                    autoPlayInterval: const Duration(seconds: 8),
                    autoPlay: true,
                    aspectRatio: 1.0,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      _intstream.sink.add(index);
                    },
                  ),
                ),
                Positioned(
                  bottom: 12,
                  child: SizedBox(
                    width: widget.size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.sliderlist.map(
                        (ib) {
                          int index = widget.sliderlist.indexOf(ib);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: snapshot.data == index
                                  ? whit
                                  : whit.withOpacity(0.4),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
          ],
        );
      },
    );
  }
}
