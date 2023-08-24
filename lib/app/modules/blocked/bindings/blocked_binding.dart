import 'package:get/get.dart';

import '../controllers/blocked_controller.dart';

class BlockedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockedController>(
      () => BlockedController(),
    );
  }
}
