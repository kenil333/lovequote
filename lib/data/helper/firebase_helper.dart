import 'package:firebase_database/firebase_database.dart';
import 'package:package_info_plus/package_info_plus.dart';

import './../../domain/all.dart';

class FirebaseHelper {
  final _fire = FirebaseDatabase.instance;

  Future<List<PicQoute>> getpicquotes() async {
    List<PicQoute> _list = [];
    await _fire.ref("PicQuotes").once().then(
      (DatabaseEvent event) {
        (event.snapshot.value as Map).forEach(
          (key, value) {
            _list.add(PicQoute(id: key, image: value));
          },
        );
      },
    );
    return _list;
  }

  Future<List<Article>> getarticles() async {
    List<Article> _list = [];
    await _fire.ref("Articles").once().then(
      (DatabaseEvent event) {
        (event.snapshot.value as Map).forEach(
          (key, value) {
            _list.add(
              Article(
                id: key,
                title: value["Title"],
                content: value["Content"],
                image: value["Image"],
              ),
            );
          },
        );
      },
    );
    return _list;
  }

  Future<List<QuoteModel>> getquotes() async {
    List<QuoteModel> _list = [];
    await _fire.ref("Quotes").once().then(
      (DatabaseEvent event) {
        (event.snapshot.value as Map).forEach(
          (key, value) {
            _list.add(
              QuoteModel(
                id: key,
                quote: value["Quote"],
                category: value["Category"],
              ),
            );
          },
        );
      },
    );
    return _list;
  }

  Future<bool> updaterequired(String platform) async {
    bool _update = true;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await _fire.ref("Versions/$platform").once().then(
      (DatabaseEvent event) {
        if (packageInfo.version == (event.snapshot.value as Map)["Version"] &&
            packageInfo.buildNumber == (event.snapshot.value as Map)["Build"]) {
          _update = false;
        }
      },
    );
    return _update;
  }

  Future<List<String>> getimages() async {
    List<String> _list = [];
    await _fire.ref("Images").once().then(
      (DatabaseEvent event) {
        (event.snapshot.value as Map).forEach(
          (key, value) {
            _list.add(value);
          },
        );
      },
    );
    return _list;
  }

  Future<String> gettodayquote() async {
    String _quote = "";
    await _fire.ref("TodayQuote").once().then(
      (DatabaseEvent event) {
        _quote = (event.snapshot.value as String);
      },
    );
    return _quote;
  }

  Future<List<VideoModel>> getvideos() async {
    List<VideoModel> _list = [];
    await _fire.ref("Videos").once().then(
      (DatabaseEvent event) {
        (event.snapshot.value as Map).forEach(
          (key, value) {
            _list.add(
              VideoModel(
                id: key,
                title: value["Title"],
                days: DateTime.now()
                    .difference(DateTime.parse(value["Date"]))
                    .inDays,
                image: value["Image"],
                time: value["Time"],
                link: value["Link"],
                channellink: value["ChannelLink"],
              ),
            );
          },
        );
      },
    );
    if (_list.length > 1) {
      _list.sort((a, b) => a.days.compareTo(b.days));
    }
    return _list;
  }
}
