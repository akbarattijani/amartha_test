// ignore_for_file: constant_identifier_names

/*
  @author AKBAR <akbar.attijani@gmail.com>
 */

import 'package:get/get.dart';

class MainController extends GetxController {

    static const int ACTIVE = 1;
    static const int INACTIVE = 2;

    var data = <int, int>{}.obs;
    var value = <int, String>{}.obs;

    void addItems(int key, String val) {
        data.putIfAbsent(key, () => ACTIVE);
        value.putIfAbsent(key, () => val);
    }

    void removeItem(int key) {
        data.remove(key);
        value.remove(key);
    }

    void inactiveItem(int key) => data[key] = INACTIVE;
}

class MainBinding extends Bindings {
    @override
    void dependencies() {
        Get.lazyPut<MainController>(() => MainController());
    }
}