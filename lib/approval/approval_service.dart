// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/config/service_config.dart';

class ApprovalService {
  var message = '';
  var approval = '';
  Future<bool> accceptance(int approval, int reportId, String token) async {
    // var url = Uri.parse(
    //     '${ServiceConfig.domainNameServer}${ServiceConfig.approval}/$reportId?approved=$approval');
    var url = Uri.parse(
        'https://cityway-reports.katbi.net/api/report/approval/$reportId?approved=$approval');
    print("accceptance");

    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'User-Agent': 'PostmanRuntime/7.37.0',
      'Connection': 'keep-alive'
    });

    print(response.statusCode);
    print(response.body);
    var jsonresponse = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonresponse = jsonDecode(response.body);
      message = jsonresponse['message'];
      print(message);
      return true;
    } else if (response.statusCode == 422 || response.statusCode == 500) {
      message = jsonresponse['message'];
      print(message);
      return false;
    } else {
      message = jsonresponse['message'];
      print(message);
      return false;
    }
  }

  Future<bool> update(int reportId, String token) async {
    var url = Uri.parse(
        '${ServiceConfig.domainNameServer}${ServiceConfig.update}/$reportId');
    print("url: $url");

    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'User-Agent': 'PostmanRuntime/7.37.0',
      'Connection': 'keep-alive'
    });

    print(response.statusCode);
    print(response.body);
    var jsonresponse = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonresponse = jsonDecode(response.body);
      message = jsonresponse['message'];
      print(message);
      return true;
    } else if (response.statusCode == 422 || response.statusCode == 500) {
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
