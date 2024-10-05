import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:travel_app/Models%202/userModel.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/login/login.dart';
import 'package:travel_app/pages/MainScreen.dart';
import 'package:travel_app/pages/ProfilePage.dart';

class LoginController extends GetxController {
  //RxList<DatumC> dataList = RxList<DatumC>();
  final box = GetStorage();
  RxBool loading = false.obs;
  RxBool pf = false.obs;
  RxInt miles = 10000.obs;
  RxDouble points = 0.0.obs;

  void convertFunction() {
    points.value = miles.value * 0.6;
    miles.value = 0;
  }

  void loginFunction(String data) async {
    loading.value = true;

    final url = Uri.parse('http://51.120.240.58:8083/api/user/login');
    Map<String, String> headers = {'content-Type': 'application/json'};

    try {
      final response = await http.post(url, headers: headers, body: data);

      //print(jsonDecode(response.body)['data']);
      if (response.statusCode == 200) {
        UserModel userdata = UserModelFromJson(response.body);

        var user = jsonDecode(response.body)['user1'];

        box.write("token", userdata.user1.token);
        box.write("userid", userdata.user1.id);
        box.write("user", user);

        Get.snackbar(
            'you are succefully logged in', "Enjoy your awesome experience",
            colorText: kLightwhite,
            backgroundColor: kPrimary,
            icon: Icon(Ionicons.fast_food_outline));

        loading.value = false;
        pf.value = true;

        Get.off(() => ProfilePage(),
            transition: Transition.fade, duration: Duration(milliseconds: 900));
      }
      if (response.statusCode == 400) {
        String text = jsonDecode(response.body)["message"];

        Get.snackbar('  you have something wrong', "$text",
            messageText: Text(
              "$text",
              style: TextStyle(fontSize: 18, color: kLightwhite),
            ),
            colorText: kDark,
            backgroundColor: kRed,
            icon: Icon(Ionicons.fast_food_outline));
        Timer.periodic(Duration(seconds: 1), (timer) {
          loading.value = false;
        });
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  void logout() {
    box.erase();
    pf.value = false;

    print(pf.value);
    Get.off(() => LoginPage(),
        transition: Transition.fade, duration: Duration(milliseconds: 900));
  }
}
