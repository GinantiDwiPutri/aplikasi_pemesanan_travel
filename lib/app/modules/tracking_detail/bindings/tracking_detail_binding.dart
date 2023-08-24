import 'package:get/get.dart';

import '../controllers/tracking_detail_controller.dart';

class TrackingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackingDetailController>(
      () => TrackingDetailController(),
    );
  }
}
