import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/login/login.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class RegisterController extends GetxController {
  final box = GetStorage();
  final http.Client client;
  RxBool loading = false.obs;

  // Constructor with an optional client parameter, defaulting to `http.Client()`
  RegisterController({http.Client? client}) : client = client ?? http.Client();

  void registerFunction(String data) async {
    loading.value = true;
    final url = Uri.parse('http://51.120.4.43:8083/api/user/create');
    Map<String, String> headers = {'content-Type': 'application/json'};

    try {
      final response = await client.post(url, headers: headers, body: data);

      if (response.statusCode == 200) {
        String text = jsonDecode(response.body)["message"];
        Get.snackbar(
          'Your account has been successfully created',
          text,
          backgroundColor: kPrimary,
          colorText: kLightwhite,
          icon: Icon(Ionicons.checkmark_circle_outline),
        );

        Timer(Duration(seconds: 3), () => loading.value = false);

        Get.offAll(
          () => LoginPage(),
          transition: Transition.fade,
          duration: Duration(milliseconds: 900),
        );
      } else if (response.statusCode == 400) {
        String text = jsonDecode(response.body)["message"];
        Get.snackbar(
          'Error',
          text,
          messageText: Text(text, style: TextStyle(fontSize: 18, color: kLightwhite)),
          colorText: kDark,
          backgroundColor: kRed,
          icon: Icon(Ionicons.alert_circle_outline),
        );

        Timer(Duration(seconds: 3), () => loading.value = false);
      }
    } catch (e) {
      print("Error during registration: $e");
      Get.snackbar(
        'Network Error',
        'Please try again later',
        backgroundColor: kRed,
        colorText: kLightwhite,
      );
      loading.value = false;
    }
  }
}
