import 'package:cityway_report_client/auth/signin/signin_controller.dart';
import 'package:get/get.dart';

class SigninBindings extends Bindings{
  @override
  void dependencies(){
    Get.put<SignInController>(SignInController());
  }
}