// ignore_for_file: avoid_print

import 'dart:convert';
import '/core/config/service_config.dart';
import '/homepage/allreport_model.dart';
import 'package:http/http.dart' as http;

class ReportListService {
  var url =
      Uri.parse(ServiceConfig.domainNameServer + ServiceConfig.getListReport);
  var url1 = Uri.parse('https://cityway.boomuae.com/api/report');
  Future<List<DataAllReport>> getReportList(String token) async {
    final response = await http.get(url1, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200) {
      print('response.statusCode: ${response.statusCode} report list');
      print("response.body: ${response.body}");
      print("token $token");
      var jsonResponse = jsonDecode(response.body);
      var reportList = Allreports.fromJson(jsonResponse);
      // for (var datum in reportList.data) {
      //   print(datum.id); // Print the 'id' property of each Datum object
      // }
      return reportList.data;
    } else {
      print("token $token");
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to load order list');
    }
  }
}
