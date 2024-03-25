// ignore_for_file: avoid_print

import 'dart:convert';

import '/auth/user_model.dart';
import '/core/config/information.dart';
import '/core/config/service_config.dart';
import '/core/native_service/secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignInService {
  var message = '';
  var token = '';
  var userID = 0;
  var username = '';
  var email = '';
  var url = Uri.parse(ServiceConfig.domainNameServer + ServiceConfig.signIn);
  Future<bool> signIn(UserData user) async {
    print("signIn");

    var response = await http.post(url, headers: {
        'User-Agent': 'PostmanRuntime/7.37.0',
      'Accept': 'application/json',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive'
    }, body: {
      'email': user.email,
      'password': user.password,
    });

    print(response.statusCode);
    print(response.body);
    var jsonresponse = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonresponse = jsonDecode(response.body);
      token = jsonresponse['data']['token'];
      userID = jsonresponse['data']['id'];
      username = jsonresponse['data']['username'];
      email = jsonresponse['data']['email'];
      print('user id : $userID');
      print("token $token");
      print("username $username");
      print("email $email");

      Information.TOKEN = token;
      Information.userId = userID;
      Information.username = username;
      Information.email = email;
      SecureStorage secureStorage = SecureStorage();
      await secureStorage.save("token", Information.TOKEN);
      await secureStorage.save("role", Information.role);
      await secureStorage.save("username", Information.username);
      await secureStorage.save("email", Information.email);
      await secureStorage.saveInt("id", Information.userId);
      Get.offNamed('home');

      message = jsonresponse['message'];
      print(message);
      return true;
    } else if (response.statusCode == 422 || response.statusCode == 500) {
      // message = "please verify your information";
      message = jsonresponse['message'];
      print(message);
      return false;
    } else {
      message = jsonresponse['message'];
      print(message);
      return false;
    }
  }
}
