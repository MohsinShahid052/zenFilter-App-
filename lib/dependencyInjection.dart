import 'package:get/get.dart';

import 'package:zenFilter/executables/controllers/InternetConnectivityOverall.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
