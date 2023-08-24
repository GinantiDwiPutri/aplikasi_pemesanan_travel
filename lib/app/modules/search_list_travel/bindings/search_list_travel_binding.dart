import 'package:get/get.dart';

import '../controllers/search_list_travel_controller.dart';

class SearchListTravelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchListTravelController>(
      () => SearchListTravelController(),
    );
  }
}
