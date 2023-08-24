import 'package:get/get.dart';

import '../controllers/choose_seat_controller.dart';

class ChooseSeatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseSeatController>(
      () => ChooseSeatController(),
    );
  }
}
