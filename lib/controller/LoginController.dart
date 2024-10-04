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
import 'package:travel_app/pages/MainScreen.dart';

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

    // Check all response codes
    if (response.statusCode == 200) {
      UserModel userdata = UserModelFromJson(response.body);

      // Ensure user1 exists in the response
      if (userdata.user1 != null) {
        var user = userdata.user1;
        
        box.write("token", user.token);
        box.write("userid", user.id);
        box.write("user", user);

        Get.snackbar(
            'You are successfully logged in', "Enjoy your awesome experience",
            colorText: kLightwhite,
            backgroundColor: kPrimary,
            icon: Icon(Ionicons.fast_food_outline));

        // Stop the loading indicator
        loading.value = false;
        pf.value = true;

        // Navigate to the next page
        Get.off(() => MainScreen(),
            transition: Transition.fade, duration: Duration(milliseconds: 900));
      } else {
        // Handle missing user data
        Get.snackbar('Error', 'User data is missing from response',
            backgroundColor: kRed, colorText: kLightwhite);
        loading.value = false;
      }
    } else {
      String errorText = jsonDecode(response.body)["message"] ?? "Unknown error";
      Get.snackbar('Login failed', errorText,
          backgroundColor: kRed, colorText: kLightwhite);

      loading.value = false;
    }
  } catch (e) {
    // Handle any errors
    Get.snackbar('Error', 'An unexpected error occurred: $e',
        backgroundColor: kRed, colorText: kLightwhite);
    loading.value = false;
  } finally {
    // Ensure loading is stopped in all cases
    loading.value = false;
  }
}


  void logout() {
    box.erase();
  }
}

//dzdz