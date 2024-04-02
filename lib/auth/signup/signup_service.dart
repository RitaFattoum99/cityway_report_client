// ignore_for_file: avoid_print
import 'dart:convert';

import '/auth/user_model.dart';
import '/core/config/information.dart';
import '/core/config/service_config.dart';
import '/core/native_service/secure_storage.dart';
import 'package:http/http.dart' as http;

class SignUpService {
  var message = '';
  var token = '';
  var role = '';
  var userID = 0;
  var id = 0;
  var username = '';
  var email = '';
  var password = '';
  var confirmPassword = '';

  var url = Uri.parse(ServiceConfig.domainNameServer + ServiceConfig.register);
  Future<bool> register(UserData user) async {
    print("register");
    print("username: ${user.username}");
    print("email: ${user.email}");
    print("password: ${user.password}");
    print("confirmPassword: ${user.confirmPassword}");

    try {
      var response = await http.post(url, headers: {
        'User-Agent': 'PostmanRuntime/7.37.0',
        'Accept': 'application/json',
        'Connection': 'keep-alive'
      }, body: {
        'username': user.username,
        'email': user.email,
        'password': user.password,
        'password_confirmation': user.confirmPassword,
      });

      print(response.statusCode);
      print(response.body);
      var jsonresponse = jsonDecode(response.body);
      message = jsonresponse['message'];
      if (response.statusCode == 200 || response.statusCode == 201) {
        // message = "User created successfully";
        token = jsonresponse['data']['token'];
        role = jsonresponse['data']['roles'][0];
        userID = jsonresponse['data']['id'];
        username = jsonresponse['data']['username'];
        print(response.statusCode);
        print(response.body);
        print(message);
        print('user id : $userID');
        print("role: $role");
        print("user name: $username");
        print("token : $token");
        Information.TOKEN = token;
        SecureStorage secureStorage = SecureStorage();
        await secureStorage.save("token", Information.TOKEN);
        Information.role = role;
        Information.userId = userID;
        await secureStorage.saveInt("id", Information.userId);

        return true;
      } else if (response.statusCode == 422 || response.statusCode == 500) {
        // message = "please verify your information";
        print(response.statusCode);
        print(response.body);
        print(message);
        return false;
      } else {
        // message = "there is error..";
        print(response.statusCode);
        print(response.body);
        print(message);
        return false;
      }
    } catch (e) {
      print("Error: $e");
      message = "An error occurred";
      return false;
    }
  }
}
