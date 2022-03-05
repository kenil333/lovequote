import 'package:get/get.dart';

class PreviewController extends GetxController {
  RxInt imagerx = 0.obs;
  RxInt fontsizerx = 15.obs;
  RxInt colorx = 0.obs;
  RxBool editrx = false.obs;
  RxBool underlinerx = false.obs;
  RxBool capitalrx = false.obs;
  RxBool lodingrx = false.obs;
  RxString selectedrx = "Size".obs;
  RxString fontstylerx = "roboto_regular".obs;
  RxString alignrx = "center".obs;
  RxDouble opacityrx = 0.4.obs;

  imagechange(int i) => imagerx.value = i;
  fontsizechange(int i) => fontsizerx.value = i;
  colorchange(int i) => colorx.value = i;
  editchange(bool value) => editrx.value = value;
  underlinechange(bool value) => underlinerx.value = value;
  capitalchange(bool value) => capitalrx.value = value;
  selectedchange(String change) => selectedrx.value = change;
  fontstylechange(String change) => fontstylerx.value = change;
  alignchange(String change) => alignrx.value = change;
  opacitychange(double d) => opacityrx.value = d;
  lodingchange(bool value) => lodingrx.value = value;
}
