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
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      final response = await client.post(url, headers: headers, body: data);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody["message"] ?? "Registration completed";

        showSnackbar(
          title: 'Your account has been successfully created',
          message: message,
          backgroundColor: kPrimary,
          icon: Ionicons.fast_food,
        );

        // Wait for a few seconds before navigating away
        await Future.delayed(Duration(seconds: 3));
        loading.value = false;

        // Navigate to the LoginPage
        Get.offAll(() => LoginPage(), transition: Transition.fade, duration: Duration(milliseconds: 900));
      } else if (response.statusCode == 400) {
        final responseBody = jsonDecode(response.body);
        final message = responseBody["message"] ?? "An error occurred";

        showSnackbar(
          title: 'You have something wrong',
          message: message,
          backgroundColor: kRed,
          icon: Ionicons.fast_food_outline,
          isError: true,
        );

        await Future.delayed(Duration(seconds: 3));
        loading.value = false;
      } else {
        handleUnexpectedError(response.statusCode);
      }
    } catch (e) {
      handleException(e);
    } finally {
      loading.value = false;
    }
  }

  void showSnackbar({
    required String title,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    bool isError = false,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: isError ? kDark : kLightwhite,
      icon: Icon(icon),
    );
  }

  void handleUnexpectedError(int statusCode) {
    Get.snackbar(
      'Unexpected Error',
      'Please try again later. Error code: $statusCode',
      backgroundColor: kRed,
      colorText: kLightwhite,
    );
  }

  void handleException(Object exception) {
    print('Error during registration: $exception');
    Get.snackbar(
      'Error',
      'An unexpected error occurred. Please check your connection and try again.',
      backgroundColor: kRed,
      colorText: kLightwhite,
    );
  }
}
