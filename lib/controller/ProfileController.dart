import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import 'package:travel_app/Models%202/voleModel.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/pages/allvoles.dart';

class ProfileController extends GetxController {
  List<FlightData> alldataList = [];

  var count = 0.obs;
  var loading = true.obs;

  RxString id = "".obs;

  void updateUserFunction(String id, Map<String, String> data) async {
    loading.value = true;

    final url = Uri.parse('http://51.120.240.58:8083/api/user/update/$id');
    Map<String, String> headers = {'Content-Type': 'application/json'};

    print("eeeee");

    try {
      final response =
          await http.patch(url, headers: headers, body: jsonEncode(data));

      print(jsonDecode(response.body));
    } catch (e) {
      print(e);
    } finally {}
  }
}
