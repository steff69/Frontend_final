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

  Future<void> registerFunction(String data) async {
    loading.value = true;
    final url = Uri.parse('http://51.120.4.43:8083/api/user/create');
    Map<String, String> headers = {'content-Type': 'application/json'};

    try {
      final response = await client.post(url, headers: headers, body: data);

      if (response.statusCode == 200) {
        // Parse the response body safely
        final responseBody = jsonDecode(response.body);
        final message = responseBody?["message"] ?? "Registration completed";

        Get.snackbar(
          'Your account has been successfully created',
          message,
          backgroundColor: kPrimary,
          colorText: kLightwhite,
          icon: Icon(Ionicons.fast_food),
        );

        // Use Future.delayed instead of Timer for better async handling
        await Future.delayed(Duration(seconds: 3));
        loading.value = false;

        Get.offAll(
          () => LoginPage(),
          transition: Transition.fade,
          duration: Duration(milliseconds: 900),
        );
      } else if (response.statusCode == 400) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody?["message"] ?? "An error occurred";

        Get.snackbar(
          'You have something wrong',
          message,
          messageText: Text(message, style: TextStyle(fontSize: 18, color: kLightwhite)),
          colorText: kDark,
          backgroundColor: kRed,
          icon: Icon(Ionicons.fast_food_outline),
        );

        await Future.delayed(Duration(seconds: 3));
        loading.value = false;
      } else {
        // Handle unexpected status codes
        Get.snackbar(
          'Unexpected Error',
          'Please try again later. Error code: ${response.statusCode}',
          backgroundColor: kRed,
          colorText: kLightwhite,
        );
        loading.value = false;
      }
    } catch (e) {
      // Enhanced error handling
      print('Error during registration: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please check your connection and try again.',
        backgroundColor: kRed,
        colorText: kLightwhite,
      );
      loading.value = false;
    }
  }
}
