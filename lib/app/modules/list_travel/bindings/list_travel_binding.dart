import 'package:get/get.dart';

import '../controllers/list_travel_controller.dart';

class ListTravelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTravelController>(
      () => ListTravelController(),
    );
  }
}
