// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';

import '../core/native_service/secure_storage.dart';
import 'approval_service.dart';

class ApprovalController extends GetxController {
  var approval = 0;
  var reportId = 0;

  var approvalStatus = false;
  var message;
  late SecureStorage secureStorage = SecureStorage();

  ApprovalService service = ApprovalService();

  Future<void> doAcceptance(int approval, int reportId) async {
    secureStorage = SecureStorage();
    String? token = await secureStorage.read("token");

    approvalStatus = await service.accceptance(approval, reportId, token!);
    message = service.message;
  }

  Future<void> doDone(int reportId) async {
    secureStorage = SecureStorage();
    String? token = await secureStorage.read("token");

    approvalStatus = await service.update(reportId, token!);
    message = service.message;
  }
}
