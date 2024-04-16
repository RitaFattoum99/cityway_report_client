// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import '/auth/user_model.dart';
import '/core/config/information.dart';
import '/core/config/service_config.dart';
import '/core/native_service/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Ensure this is added for MediaType

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
  Future<bool> register(UserData user, File signupSignatureFile) async {
    print("Registering user...");
    try {
      var request = http.MultipartRequest('POST', url)
        ..fields['username'] = user.username!
        ..fields['email'] = user.email!
        ..fields['password'] = user.password!
        ..fields['password_confirmation'] = user.confirmPassword!
        ..headers.addAll({
          'User-Agent': 'PostmanRuntime/7.37.0',
          'Accept': 'application/json',
          'Connection': 'keep-alive'
        })
        ..files.add(await http.MultipartFile.fromPath(
          'signature', // This should match the name expected by your backend
          signupSignatureFile.path,
          contentType:
              MediaType('image', 'jpeg'), // Adjust the type accordingly
        ));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.statusCode);
      print(response.body);
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['message'];

      if (response.statusCode == 200 || response.statusCode == 201) {
        token = jsonResponse['data']['token'];
        role = jsonResponse['data']['roles'][0];
        userID = jsonResponse['data']['id'];
        username = jsonResponse['data']['username'];
        email = jsonResponse['data']['email'];

        print(
            "User ID: $userID, Role: $role, Username: $username, Token: $token");

        Information.TOKEN = token;
        Information.userId = userID;
        Information.username = username;
        Information.email = email;
        Information.role = role;
        SecureStorage secureStorage = SecureStorage();
        await secureStorage.save("token", token);
        await secureStorage.save("role", role);
        await secureStorage.save("username", username);
        await secureStorage.save("email", email);
        await secureStorage.saveInt("id", userID);

        return true;
      } else {
        print("Response code: ${response.statusCode}");
        print("Response body: ${response.body}");
        print("Message: $message");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      message = "An error occurred";
      return false;
    }
  }
}
