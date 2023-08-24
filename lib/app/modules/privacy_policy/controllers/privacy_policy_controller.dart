import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyController extends GetxController {
  Rx<double> progressIndicator = 0.0.obs;
  Rx<bool> isLoading = true.obs;

  WebViewController webviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
      Uri.parse(
        'https://berangkut.fun/privacy-policy',
      ),
    );

  @override
  void onInit() {
    super.onInit();
    webviewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {
          progressIndicator.value = progress / 100;
        },
        onPageStarted: (url) {
          isLoading.value = true;
        },
        onPageFinished: (url) {
          isLoading.value = false;
        },
        onWebResourceError: (error) {},
      ),
    );
  }

  @override
  void onClose() {
    super.onClose();
    webviewController.clearCache();
    webviewController.clearLocalStorage();
  }
}
