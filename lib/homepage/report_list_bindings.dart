import 'package:get/get.dart';

import 'reoport_list_controller.dart';

class ReportListBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ReportListController>(ReportListController());
  }
}
