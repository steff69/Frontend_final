import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/Models%202/plaveModel.dart';

class SerchController extends GetxController {
  //RxList<DatumC> dataList = RxList<DatumC>();

  RxList<Datum> dataSearch = RxList<Datum>([]);

  RxBool isleoding = true.obs;
  RxString str = 'a'.obs;

  void getSearchData({required String searchdata}) async {

    str.value = 'a';
    dataSearch.clear();

    final url = Uri.parse('http://51.120.240.58:8083/api/Vole/search/$searchdata');

    try {
      final response = await http.get(url);

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        jsonDecode(response.body)
            .forEach((e) => dataSearch.add(Datum.fromJson(e)));
        str.value = '';
      }
    } catch (e) {
      print(e);
    } finally {}
  }
}
