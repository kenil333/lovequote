import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './../../domain/all.dart';

class GlobalCache extends GetxController {
  RxBool vibraterx = false.obs;
  RxBool darkmoderx = false.obs;
  RxBool plainbackrx = false.obs;
  RxBool localnotirx = false.obs;
  // RxBool picnotirx = false.obs;
  // RxBool vidnotirx = false.obs;
  // RxBool remonotirx = false.obs;
  // RxBool artinotirx = false.obs;
  RxDouble speechraterx = 0.0.obs;
  RxDouble pitchrx = 0.0.obs;
  RxDouble articlefontrx = 0.0.obs;
  RxList<QuoteModel> favmessagerx = <QuoteModel>[].obs;
  RxList<PicQoute> favpicrx = <PicQoute>[].obs;
  RxList<PicQoute> picquotesrx = <PicQoute>[].obs;
  RxList<Article> articlerx = <Article>[].obs;
  RxList<QuoteModel> quotesrx = <QuoteModel>[].obs;
  RxList<String> imagesrx = <String>[].obs;
  RxString todayquoterx = "".obs;

  vibratechange(bool value) => vibraterx.value = value;
  darkmodechange(bool value) => darkmoderx.value = value;
  plainbackchange(bool value) => plainbackrx.value = value;
  localnotichange(bool value) => localnotirx.value = value;
  // picnotichange(bool value) => picnotirx.value = value;
  // vidnotichange(bool value) => vidnotirx.value = value;
  // remotnotichange(bool value) => remonotirx.value = value;
  // articlenotichange(bool value) => artinotirx.value = value;
  speeechratchange(double value) => speechraterx.value = value;
  pitchchange(double value) => pitchrx.value = value;
  articlefontchange(double value) => articlefontrx.value = value;

  picquotechange(List<PicQoute> list) => picquotesrx.value = list;
  articlechange(List<Article> list) => articlerx.value = list;
  quoteschange(List<QuoteModel> list) => quotesrx.value = list;
  imageschange(List<String> list) => imagesrx.value = list;

  todayquotechange(String quote) => todayquoterx.value = quote;

  vibrateclick() {
    if (vibraterx.value) {
      HapticFeedback.heavyImpact();
    }
  }

  fetchfavmess() async {
    List<QuoteModel> _list = [];
    final _data = await MessageDbHelper.getData();
    _list = _data
        .map(
          (e) => QuoteModel(
            id: e["id"],
            quote: e["mess"],
            category: e["cate"],
          ),
        )
        .toList();
    favmessagerx.value = _list;
  }

  faviconpress(String id, String message, String category) {
    final _found = foundmess(id);
    if (_found) {
      removefromfavmess(id);
    } else {
      addintofavmess(id, message, category);
    }
  }

  foundmess(String id) {
    return favmessagerx.any((element) => element.id == id);
  }

  addintofavmess(String id, String message, String category) async {
    await MessageDbHelper.insert({
      "id": id,
      "mess": message,
      "cate": category,
    });
    favmessagerx.add(QuoteModel(id: id, quote: message, category: category));
  }

  removefromfavmess(String id) async {
    await MessageDbHelper.delete(id);
    final int _index = favmessagerx.indexWhere((element) => element.id == id);
    favmessagerx.removeAt(_index);
  }

  /////
  ///
  ///
  ///

  fetchfavpic() async {
    List<PicQoute> _list = [];
    final _data = await PicDbHelper.getData();
    _list = _data
        .map(
          (e) => PicQoute(
            id: e["id"],
            image: e["mess"],
          ),
        )
        .toList();
    favpicrx.value = _list;
  }

  favpiciconpress(String id, String image) {
    final _found = foundpic(id);
    if (_found) {
      removefromfavpic(id);
    } else {
      addintofavpic(id, image);
    }
  }

  foundpic(String id) {
    return favpicrx.any((element) => element.id == id);
  }

  addintofavpic(String id, String image) async {
    await PicDbHelper.insert({
      "id": id,
      "mess": image,
    });
    favpicrx.add(PicQoute(id: id, image: image));
  }

  removefromfavpic(String id) async {
    await PicDbHelper.delete(id);
    final int _index = favpicrx.indexWhere((element) => element.id == id);
    favpicrx.removeAt(_index);
  }
}
