import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_app/Models%202/RegisterModel.dart';
import 'package:travel_app/common/EmailTextField.dart';
import 'package:travel_app/common/PasswordTextField.dart';
import 'package:travel_app/common/shimmers/cutomButtomn.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/controller/RegisterController.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordCFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCFocusNode.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(RegisterController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, // Transparent app bar
        title: Padding(
          padding: EdgeInsets.only(left: 100),
          child: Text(
            'Sign Up',
            style: TextStyle(
                color: kwhite, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF002C3E), Color(0xFF00506A)], // Background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(),
          child: ListView(
            children: [
              SizedBox(
                height: 5.h,
              ),

              // Image with curved corners at the bottom
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
                child: Image.asset(
                  'assets/t.jpg',
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(
                height: 35.h,
              ),

              // Form inputs with white hint and text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Email input field
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        hintStyle: TextStyle(color: Colors.white), // White hint text
                        prefixIcon: Icon(
                          CupertinoIcons.mail,
                          size: 20,
                          color: Colors.white, // White icon color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)), // Rounded corners for the border
                          borderSide: BorderSide(
                            color: Colors.white, // White border for the enabled state
                            width: 2.0, // Define border thickness
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)), // Rounded corners for the border
                          borderSide: BorderSide(
                            color: Colors.blue, // Blue border for the focused state
                            width: 2.0, // Define border thickness
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // White input text
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    // Name input field
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.white), // White hint text
                        prefixIcon: Icon(
                          CupertinoIcons.person,
                          size: 20,
                          color: Colors.white, // White icon color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)), // Rounded corners for the border
                          borderSide: BorderSide(
                            color: Colors.white, // White border for the enabled state
                            width: 2.0, // Define border thickness
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)), // Rounded corners for the border
                          borderSide: BorderSide(
                            color: Colors.blue, // Blue border for the focused state
                            width: 2.0, // Define border thickness
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // White input text
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    // Password input field
                    TextField(
                      controller: _passwordController,
                      obscureText: true, // To hide the password input
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white), // White hint text
                        prefixIcon: Icon(
                          CupertinoIcons.lock,
                          size: 20,
                          color: Colors.white, // White icon color
                        ),
                        suffixIcon: Icon(
                          Icons.visibility_off, // This icon can toggle visibility
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)), // Rounded corners for the border
                          borderSide: BorderSide(
                            color: Colors.white, // White border for the enabled state
                            width: 2.0, // Define border thickness
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)), // Rounded corners for the border
                          borderSide: BorderSide(
                            color: Colors.blue, // Blue border for the focused state
                            width: 2.0, // Define border thickness
                          ),
                        ),
                      ),
                      style: TextStyle(color: Colors.white), // White input text
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    // Register button
                    Obx(() => c.loading.value
                        ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeAlign: 1,
                        ))
                        : CustomButton(
                      onTap: () {
                        RegisterModel model = RegisterModel(
                            email: _emailController.text,
                            password: _passwordController.text,
                            username: _nameController.text);
                        String data = RegisterModelToJson(model);
                        c.registerFunction(data);
                      },
                      text: "SIGN UP",
                      btnheigh: 35.h,
                    )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
