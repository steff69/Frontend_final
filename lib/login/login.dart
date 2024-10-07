import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:travel_app/Models%202/LoginModel.dart';
import 'package:travel_app/Register/register.dart';
import 'package:travel_app/common/shimmers/cutomButtomn.dart';
import 'package:travel_app/constants/constants.dart';
import 'package:travel_app/controller/LoginController.dart';
import 'package:travel_app/pages/MainScreen.dart';
import 'package:travel_app/pages/ProfilePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordCFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordCFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var c = Get.put(LoginController());

    if (c.pf.value == true) {
      return ProfilePage();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, // Make app bar background transparent
        title: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
          child: Icon(Icons.arrow_back),
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

              // Making image with bottom convex corners
              ClipRRect(
                borderRadius: BorderRadius.only(
                  
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),// Convex bottom right
// Convex bottom right
                ),
                child: Image.asset('assets/cen.png'), // Image at the top
              ),

              // Add space between the image and quote
              SizedBox(
                height: 20.h, // Adjust this for more or less space
              ),

              // Quote Styled Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '“Discover More with Every Login”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontStyle: FontStyle.italic, // Make the text italic
                    fontWeight: FontWeight.w300, // Light weight to give it a "quote" feel
                    letterSpacing: 1.2, // Add letter spacing to make it more elegant
                  ),
                ),
              ),

              // Adding more space between the quote and "Sign In" text
              SizedBox(
                height: 30.h, // Adjust this for more or less space
              ),

              // Sign In Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold, // Bold and larger to stand out
                  ),
                ),
              ),

              // Space between the quote and the login fields
              SizedBox(
                height: 30.h,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
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

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => RegisterPage());
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Obx(() => c.loading.value
                        ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeAlign: 1,
                        ))
                        : CustomButton(
                      onTap: () {
                        LoginModel model = LoginModel(
                            email: _emailController.text,
                            password: _passwordController.text);
                        String data = loginModelToJson(model);
                        c.loginFunction(data);
                      },
                      text: "L O G I N",
                      btnheigh: 35.h,
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
