import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/Models%202/plaveModel.dart';
import 'package:travel_app/Models%202/voleModel.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/pages/allvoles.dart';

class VoleMainController extends GetxController {
  List<FlightData> alldataList = [];

  var count = 0.obs;
  var loading = true.obs;

  RxString id = "".obs;

  void searchVoleMainFunction(String fm, String to) async {
    loading.value = true;

    final url = Uri.parse('http://10.0.2.2:5000/api/VoleMain/$fm/$to');
    Map<String, String> headers = {'content-Type': 'application/json'};

    try {
      final response = await http.get(url, headers: headers);

      //print(jsonDecode(response.body)['data']);
      if (response.statusCode == 200) {
        FlightModel data = FlightModel.fromJson(jsonDecode(response.body));
        alldataList = data.data;

        Get.offAll(() => AllVolesPage(alldataList: alldataList),
            transition: Transition.fade, duration: Duration(milliseconds: 900));

        print(alldataList);
      }
    } catch (e) {
      print(e);
    } finally {}
  }
}
