import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _control = Get.put(GlobalCache());
  final _popular = ListIntStream();
  final _featured = ListIntStream();
  final _slider = ListIntStream();
  final _sliderimage = ListIntStream();

  @override
  void initState() {
    List<int> _sliderlist = [];
    List<int> _sliderimagelist = [];
    List<int> _poplist = [];
    List<int> _featulist = [];
    List.generate(5, (_) {
      int randomint = Random().nextInt(_control.quotesrx.length);
      while (_sliderlist.contains(randomint)) {
        randomint = Random().nextInt(_control.quotesrx.length);
      }
      _sliderlist.add(randomint);
    });
    _slider.sink.add(_sliderlist);
    List.generate(5, (_) {
      int randomint = Random().nextInt(_control.imagesrx.length);
      while (_sliderimagelist.contains(randomint)) {
        randomint = Random().nextInt(_control.imagesrx.length);
      }
      _sliderimagelist.add(randomint);
    });
    _sliderimage.sink.add(_sliderimagelist);
    List.generate(4, (_) {
      int randomint = Random().nextInt(lovequoteslist.length);
      while (_poplist.contains(randomint)) {
        randomint = Random().nextInt(lovequoteslist.length);
      }
      _poplist.add(randomint);
    });
    _popular.sink.add(_poplist);
    List.generate(4, (_) {
      int randomint = Random().nextInt(messagelist.length);
      while (_featulist.contains(randomint)) {
        randomint = Random().nextInt(messagelist.length);
      }
      _featulist.add(randomint);
    });
    _featured.sink.add(_featulist);
    super.initState();
  }

  @override
  void dispose() {
    _popular.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: _control.darkmoderx.value ? screenbackdark : whit,
        appBar: appbarpref(_control.darkmoderx.value ? false : true,
            _control.darkmoderx.value ? appbardark : whit),
        drawer: DrawerWidget(size: size),
        body: Builder(builder: (context) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                color: _control.darkmoderx.value ? appbardark : whit,
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                        _control.vibrateclick();
                      },
                      child: Image.asset(
                        menuimg,
                        width: size.width * 0.07,
                        fit: BoxFit.contain,
                        color: _control.darkmoderx.value ? whit : black87,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: size.width * 0.06),
                          Text(
                            "Deep Love Quotes",
                            style: TextStyle(
                              color: _control.darkmoderx.value ? whit : black87,
                              fontSize: size.width * 0.05,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _control.vibrateclick();
                        showDialog(
                          context: context,
                          builder: (context) => RateDilog(size: size),
                        );
                      },
                      child: Icon(
                        Icons.favorite_rounded,
                        color: redcol,
                        size: size.width * 0.07,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamBuilder<List<int>>(
                        stream: _slider.stream,
                        initialData: const [1, 2, 3, 4, 5],
                        builder: (context, slidersnap) {
                          return StreamBuilder<List<int>>(
                            stream: _sliderimage.stream,
                            initialData: const [1, 2, 3, 4, 5],
                            builder: (context, slideimasnap) {
                              return SliderWidget(
                                size: size,
                                vibrate: () {
                                  _control.vibrateclick();
                                },
                                sliderlist: slidersnap.data!,
                                sliderimagelist: slideimasnap.data!,
                              );
                            },
                          );
                        },
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                        ),
                        child: Row(
                          children: [
                            for (int i = 0; i < categorylist.length; i++)
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (i == 0) {
                                      routepush(
                                        context,
                                        SimpleListingScreen(
                                          title: "Love Quotes",
                                          listofscreen: lovequoteslist,
                                        ),
                                      );
                                    } else if (i == 3) {
                                      routepush(
                                        context,
                                        const ArticleListScreen(),
                                      );
                                    } else if (i == 1) {
                                      routepush(
                                        context,
                                        const FavouritePicQuoteScreen(
                                          title: "Picture Quotes",
                                        ),
                                      );
                                    } else {
                                      routepush(
                                        context,
                                        const QuotesListScreen(
                                          title: "Love Poems",
                                        ),
                                      );
                                    }
                                    _control.vibrateclick();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: size.width * 0.125,
                                        height: size.width * 0.125,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: categorylist[i]["color"],
                                        ),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          categorylist[i]["image"],
                                          width: size.width * 0.06,
                                          fit: BoxFit.contain,
                                          color: whit,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        categorylist[i]["title"],
                                        style: TextStyle(
                                          fontSize: size.width * 0.035,
                                          color: _control.darkmoderx.value
                                              ? whit
                                              : black87,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomLable(
                        size: size,
                        title: "Most Popular",
                        dark: _control.darkmoderx.value,
                      ),
                      const SizedBox(height: 4),
                      StreamBuilder<List<int>>(
                        stream: _popular.stream,
                        initialData: const [],
                        builder: (context, isnap) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: size.width * 0.025,
                              mainAxisSpacing: 20,
                              childAspectRatio: 2 / 1.6,
                            ),
                            itemCount: isnap.data!.length,
                            itemBuilder: (context, i) => GridStempWidget(
                              size: size,
                              title: lovequoteslist[isnap.data![i]].title,
                              image: lovequoteslist[isnap.data![i]].image,
                              onclick: () {
                                routepush(
                                  context,
                                  QuotesListScreen(
                                    title: lovequoteslist[isnap.data![i]].title,
                                  ),
                                );
                                _control.vibrateclick();
                              },
                              dark: _control.darkmoderx.value,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 35),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Messages by Category",
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                color:
                                    _control.darkmoderx.value ? whit : black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                routepush(
                                  context,
                                  SimpleListingScreen(
                                    title: "Love Messages",
                                    listofscreen: messagelist,
                                  ),
                                );
                                _control.vibrateclick();
                              },
                              child: Text(
                                "View All >",
                                style: TextStyle(
                                  fontSize: size.width * 0.038,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: size.width * 0.025,
                          mainAxisSpacing: 20,
                          childAspectRatio: 2 / 1.6,
                        ),
                        itemCount: 4,
                        itemBuilder: (context, i) => GridStempWidget(
                          size: size,
                          title: messagelist[i].title,
                          image: messagelist[i].image,
                          onclick: () {
                            routepush(
                              context,
                              QuotesListScreen(
                                title: messagelist[i].title,
                              ),
                            );
                            _control.vibrateclick();
                          },
                          dark: _control.darkmoderx.value,
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomLable(
                        size: size,
                        title: "Featured",
                        dark: _control.darkmoderx.value,
                      ),
                      const SizedBox(height: 8),
                      StreamBuilder<List<int>>(
                        stream: _featured.stream,
                        initialData: const [],
                        builder: (context, isnap) {
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: size.width * 0.025,
                              mainAxisSpacing: 15,
                              childAspectRatio: 2 / 2.5,
                            ),
                            itemCount: isnap.data!.length,
                            itemBuilder: (context, i) => GestureDetector(
                              onTap: () {
                                routepush(
                                  context,
                                  QuotesListScreen(
                                    title: messagelist[isnap.data![i]].title,
                                  ),
                                );
                                _control.vibrateclick();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: backimage(
                                    AssetImage(
                                        messagelist[isnap.data![i]].image),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(child: Container()),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.02,
                                      ),
                                      child: Text(
                                        messagelist[isnap.data![i]].title,
                                        textAlign: TextAlign.center,
                                        style: whitetext(size.width * 0.04),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 35),
                      GestureDetector(
                        onTap: () {
                          final _index = _control.quotesrx.indexWhere(
                            (e) => e.quote == _control.todayquoterx.value,
                          );
                          routepush(
                            context,
                            PreviewScreen(
                              id: _control.quotesrx[_index].id,
                              title: _control.quotesrx[_index].quote,
                              category: _control.quotesrx[_index].category,
                            ),
                          );
                          _control.vibrateclick();
                        },
                        child: CachedNetworkImage(
                          imageUrl: _control.imagesrx[
                              Random().nextInt(_control.imagesrx.length)],
                          imageBuilder: (context, imageProvider) => Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.06,
                              vertical: size.height * 0.1,
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: backimage(imageProvider),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Today's Quote",
                                  textAlign: TextAlign.center,
                                  style: whitetext(size.width * 0.06),
                                ),
                                SizedBox(height: size.height * 0.04),
                                Text(
                                  _control.todayquoterx.value,
                                  textAlign: TextAlign.center,
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: whitetext(size.width * 0.045),
                                ),
                              ],
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: screenbackdark,
                            ),
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
                      ),
                      const SizedBox(height: 35),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Articles",
                              style: TextStyle(
                                fontSize: size.width * 0.045,
                                color:
                                    _control.darkmoderx.value ? whit : black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                routepush(
                                  context,
                                  const ArticleListScreen(),
                                );
                                _control.vibrateclick();
                              },
                              child: Text(
                                "View All >",
                                style: TextStyle(
                                  fontSize: size.width * 0.038,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 220,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () {
                              routepush(
                                context,
                                ArticleDetailScreen(
                                  article: _control.articlerx[i],
                                ),
                              );
                              _control.vibrateclick();
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
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
